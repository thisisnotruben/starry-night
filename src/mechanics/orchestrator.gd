extends Node
class_name Orchestrator

const OBJECTIVE_TIME := [15.0, 30.0]
const COOLDOWN_TIME := [15.0, 25.0]
const FIX_TIME := [5.0, 7.0]


class ObjectiveMechanic:
	var objective_time: float = 15.0
	var cooldown_time: float = 5.0
	var fix_time: float = 5.0

	func init() -> ObjectiveMechanic:
		objective_time = rand_range(OBJECTIVE_TIME[0], OBJECTIVE_TIME[1])
		cooldown_time = rand_range(COOLDOWN_TIME[0], COOLDOWN_TIME[1])
		fix_time = rand_range(FIX_TIME[0], FIX_TIME[1])
		return self


export var SCORE_MAX := 15
export var SCORE_WIN_TIME_REDUCTION := 2.0

var blackhole_time := 0.0
var score: int = 0
var won := false
var objective_times := []

var objectives := []
var blackHole_pathFollow: PathFollow = null
var worldEnvironment: WorldEnvironment = null

onready var timer: Timer = $timer

signal game_finish(won, fell)
signal curr_score(_score, _max_score)
signal blackhole_time(_time_left)


func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	randomize()

func _process(delta) -> void:
	emit_signal("blackhole_time", timer.time_left)

func _physics_process(delta) -> void:
	update_blackhole_position()

func init(_objectives: Array, _blackHole_pathFollow: PathFollow, \
_worldEnvironment: WorldEnvironment, hud: Hud, difficulty: String) -> Node:
	objectives = _objectives
	blackHole_pathFollow = _blackHole_pathFollow
	worldEnvironment = _worldEnvironment

	connect("curr_score", hud, "set_score")
	connect("blackhole_time", hud, "set_time")
	emit_signal("curr_score", score, SCORE_MAX)

	for i in range(30):
		objective_times.append(ObjectiveMechanic.new().init())
	set_difficulty(difficulty)

	for _obj in _objectives:
		_obj.init(objective_times[randi() % objective_times.size()], true)
		_obj.connect("score", self, "track_score")
		_obj.connect("refresh_time", self, "refresh_objective_time")

	set_process(true)
	set_physics_process(true)
	return self

func set_difficulty(_difficulty: String) -> void:
	timer.stop()
	blackhole_time = get_blackhole_duration(_difficulty)
	timer.wait_time = blackhole_time
	timer.start()

func get_blackhole_duration(_difficulty: String) -> float:
	var black_hole_time: float = 0.0
	for obj in objective_times:
		black_hole_time += obj.objective_time + obj.cooldown_time
	black_hole_time = black_hole_time / (2.0 * objective_times.size()) * SCORE_MAX

	match _difficulty.to_lower():
		"easy":
			black_hole_time *= 0.62
		"medium":
			black_hole_time *= 0.58
		"hard":
			black_hole_time *= 0.54
	return black_hole_time

func track_score(_score: int) -> void:
	if won:
		return

	score += _score
	emit_signal("curr_score", score, SCORE_MAX)
	if score == SCORE_MAX:
		won = true
		emit_signal("game_finish", true, false)
	elif _score > 0:
		var time_left = timer.time_left
		timer.stop()
		timer.wait_time = time_left + _score * SCORE_WIN_TIME_REDUCTION
		timer.start()

func refresh_objective_time(_objective) -> void:
	_objective.set_time(objective_times[randi() % objective_times.size()])

func _on_timer_timeout():
	if not won:
		emit_signal("game_finish", false, false)

func update_blackhole_position() -> void:
	if timer.time_left > 0 and blackhole_time > 0:
		var time_ratio := timer.time_left / blackhole_time
		blackHole_pathFollow.unit_offset = 1.0 - time_ratio
		worldEnvironment.environment.adjustment_saturation = time_ratio
