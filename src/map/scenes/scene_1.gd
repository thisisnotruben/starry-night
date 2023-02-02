extends Spatial


func _ready() -> void:
	var orchestrator: Orchestrator = $orchestrator.init(
		$platform/objectives.get_children(),
		$blackhole/Path/PathFollow)
	orchestrator.connect("game_finish", self, "_on_game_finish")
	orchestrator.connect("curr_score", $gui/hud, "set_score")
	orchestrator.connect("blackhole_time", $gui/hud, "set_time")

	for path in $ships.get_children():
		var path_follow: Node = path.get_child(0)
		var ship: Ship = path_follow.get_child(0)
		ship.init(path_follow)

func _on_game_finish(won: bool) -> void:
	pass # TODO
