extends Spatial


func _ready() -> void:
	var orchestrator: Orchestrator = $orchestrator.init(
		$platform/objectives.get_children(),
		$blackhole/Path/PathFollow)
	orchestrator.connect("game_finish", self, "_on_game_finish")
	orchestrator.connect("curr_score", $gui/hud, "set_score")
	orchestrator.connect("blackhole_time", $gui/hud, "set_time")

func _on_game_finish(won: bool) -> void:
	pass
