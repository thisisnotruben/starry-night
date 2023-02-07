extends _State
class_name Reject

var _anim_name = "TODO: add sound as well"


func enter() -> void:
	pass
	# self.player.anim.play(_anim_name)

func _on_player_anim_finished(anim_name: String) -> void:
	pass
	# if _anim_name == anim_name:
	#	emit_signal("change_state", StateType.States.IDLE)
