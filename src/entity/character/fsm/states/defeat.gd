extends _State
class_name Defeat

var _anim_name = "defeat_anim"


func enter() -> void:
	self.player.anim.play(_anim_name)

func _on_player_anim_finished(anim_name: String) -> void:
	if _anim_name == anim_name:
		emit_signal("change_state", StateType.States.IDLE)
