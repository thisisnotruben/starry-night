extends Node2D

enum Characteristic{UP_DOWN, GLOW, ALL}
export(Characteristic) var characteristic = Characteristic.UP_DOWN

onready var tween := get_tree().create_tween().bind_node(self).set_loops() \
	.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)

func _ready():
	match characteristic:
		Characteristic.UP_DOWN:
			up_down()
		Characteristic.GLOW:
			glow()
		Characteristic.ALL:
			up_down()
			glow()

func up_down():
	var initial_position := position
	var time_delta := rand_range(1.5, 4.0)

	tween.tween_property(self, "position", \
		initial_position - Vector2(0.0, rand_range(2.0, 6.0)), time_delta)
	tween.tween_property(self, "position", initial_position, time_delta)

func glow():
	var initial_scale = scale
	var time_delta := rand_range(1.5, 4.0)

	tween.tween_property(self, "scale", \
		initial_scale * rand_range(1.05, 1.15), time_delta)
	tween.tween_property(self, "scale", initial_scale, time_delta)
