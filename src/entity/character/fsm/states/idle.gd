extends _State
class_name Idle


func enter() -> void:
	self.player.anim.play("idle_anim")

