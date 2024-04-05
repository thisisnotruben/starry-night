extends _State
class_name Win

var _anim_name := "win_anim"


func enter() -> void:
	self.player.anim.play(_anim_name)
	fsm.lock(true)

func _on_player_anim_finished(anim_name: String) -> void:
	if _anim_name == anim_name:
		fsm.lock(false)
		emit_signal("change_state", StateType.States.IDLE)
