extends Move
class_name Fall


func enter() -> void:
	fsm.lock(true)
	self.player.anim.play("fall_anim")
