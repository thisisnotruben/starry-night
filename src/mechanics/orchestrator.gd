extends Node
class_name Orchestrator

export var SCORE_MAX := 15
export var SCORE_WIN_TIME_REDUCTION := 2.0
export var BLACKHOLE_TIME := 120.0

var score: int = 0
var won := false

var objectives := []
var blackHole_pathFollow: PathFollow = null

onready var timer: Timer = $timer

signal game_finish(won)
signal curr_score(_score, _max_score)
signal blackhole_time(_time_left)


func _ready() -> void:
	timer.wait_time = BLACKHOLE_TIME
	timer.start()

func _process(delta):
	emit_signal("blackhole_time", timer.time_left)

func _physics_process(delta) -> void:
	update_blackhole_position()

func init(_objectives: Array, _blackHole_pathFollow: PathFollow) -> Node:
	objectives = _objectives
	blackHole_pathFollow = _blackHole_pathFollow
	for _obj in _objectives:
		_obj.connect("score", self, "track_score")
	return self

func track_score(_score: int) -> void:
	if won:
		return

	score += _score
	emit_signal("curr_score", score, SCORE_MAX)
	if score == SCORE_MAX:
		won = true
		emit_signal("game_finish", true)
	elif _score > 0:
		var time_left = timer.time_left
		timer.stop()
		timer.wait_time = time_left + _score * SCORE_WIN_TIME_REDUCTION
		timer.start()

func _on_timer_timeout():
	if not won:
		emit_signal("game_finish", false)

func update_blackhole_position() -> void:
	if timer.time_left > 0:
		blackHole_pathFollow.unit_offset = timer.time_left / BLACKHOLE_TIME
