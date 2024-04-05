extends _State
class_name Reject

var _anim_name = "bump_anim"


func enter() -> void:
	fsm.lock(true)
	self.player.anim.play(_anim_name)

func _on_player_anim_finished(anim_name: String) -> void:
	if _anim_name == anim_name:
		fsm.lock(false)
		emit_signal("change_state", StateType.States.IDLE)
