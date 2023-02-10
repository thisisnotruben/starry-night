extends Move
class_name Fall


func enter() -> void:
	self.player.anim.play("fall_anim")
