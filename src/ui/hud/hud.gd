extends Control
class_name Hud

onready var score_lbl = $panel/margin/vBox/score
onready var time_lbl = $panel/margin/vBox/time


func set_score(_score: int, _max_score: int) -> void:
	score_lbl.text = "%d/%d" % [_score, _max_score]

func set_time(_time: float) -> void:
	time_lbl.text = "%.0f" % _time
