extends Spatial

enum Difficulty{EASY, MEDIUM, HARD}
export(Difficulty) var _difficulty = Difficulty.MEDIUM
var difficulty: String = Difficulty.keys()[_difficulty]

var scene_path := ""


func _ready() -> void:
	var orchestrator: Orchestrator = $orchestrator.init(
		$platform/objectives.get_children(),
		$blackhole/Path/PathFollow,
		$worldEnvironment,
		$gui/hud,
		difficulty
	)
	orchestrator.connect("game_finish", self, "_on_game_finish")
	$platform/player.connect("player_fell", self, "_on_game_finish")

	for path in $ships.get_children():
		var path_follow: Node = path.get_child(0)
		var ship: Ship = path_follow.get_child(0)
		ship.init(path_follow)

func _on_game_finish(won: bool, fell: bool = false) -> void:
	scene_path = "res://src/ui/end/end_win.tscn"
	var state = StateType.States.WIN
	if not won:
		scene_path = "res://src/ui/end/end_lose.tscn"
		state = StateType.States.DEATH

	if not fell:
		var fsm = $platform/player.fsm
		fsm.change_state(state)
		fsm.lock(true)
		yield(get_tree().create_timer(2.0), "timeout")

	connect("tree_exited", self, "set_scene")
	queue_free()

func set_scene() -> void:
	Music.get_tree().change_scene(scene_path)
