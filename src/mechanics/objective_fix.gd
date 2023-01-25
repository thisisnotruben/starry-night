extends Spatial

export var objective_time: float = 15.0
export var cooldown_time: float = 5.0
export var fix_time: float = 5.0

var player: Player = null
var fixed: bool = false

onready var tween: Tween = $tween

signal score(count)


func _ready() -> void:
	$fix_timer.wait_time = fix_time
	$objective_timer.wait_time = objective_time
	$cooldown_timer.wait_time = cooldown_time
	start_objective()

func _on_area_body_entered(body) -> void:
	if body is Player:
		player = body
		if not player.fsm.is_connected("state_changed", self, "_on_player_state_changed"):
			player.fsm.connect("state_changed", self, "_on_player_state_changed")

func _on_area_body_exited(body) -> void:
	$fix_timer.stop()
	fixed = false
	player = null

func _on_player_state_changed(_state) -> void:
	if player != null and $cooldown_timer.time_left == 0.0:
		if _state == StateType.States.TOOL:
			$fix_timer.start()
			change_color(ColorN("green"), fix_time)
		else:
			$fix_timer.stop()
			change_color(ColorN("red"), $objective_timer.time_left)

func _on_fix_timer_timeout():
	fixed = $objective_timer.time_left > 0.0
	$objective_timer.stop()
	score_point()
	start_cooldown()

func _on_objective_timer_timeout() -> void:
	score_point()
	start_cooldown()

func _on_cooldown_timer_timeout():
	start_objective()

func score_point() -> int:
	var score = -1
	if fixed:
		score = 1

	if player != null:
		var state = -1
		match score:
			-1:
				state = StateType.States.DEFEAT
			1:
				state = StateType.States.VICTORY
		if state != -1:
			player.fsm.change_state(state)

	fixed = false
	return score

func change_color(color: Color, time) -> void:
	tween.remove_all()
	tween.interpolate_property($CSGCylinder, "material:albedo_color", \
		$CSGCylinder.get("material:albedo_color"), color, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property($OmniLight, "light_color", \
		$OmniLight.light_color, color, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func start_cooldown() -> void:
	$cooldown_timer.start()
	change_color(ColorN("yellow"), cooldown_time)

func start_objective() -> void:
	$objective_timer.start()
	change_color(ColorN("red"), objective_time)
