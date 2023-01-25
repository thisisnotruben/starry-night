extends _State
class_name Death


func enter() -> void:
	self.player.anim.play("death_anim")

