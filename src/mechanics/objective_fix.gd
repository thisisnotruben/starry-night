extends Spatial

export var objective_time: float = 15.0
export var cooldown_time: float = 5.0
export var fix_time: float = 5.0

var player: Player = null
var fixed: bool = false

onready var tween: Tween = $tween
onready var tween_fix: Tween = $tween_fix
onready var time_lbl: Label3D = $OmniLight/timing
onready var text_lbl: Label3D = $OmniLight/text
onready var fix_lbl: Label3D = $OmniLight/fix
onready var fix_time_lbl: Label3D = $OmniLight/fix/timing

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
	start_fix(false)
	fixed = false
	player = null

func _on_player_state_changed(_state) -> void:
	if player != null and $cooldown_timer.time_left == 0.0:
		start_fix(_state == StateType.States.TOOL)

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
		emit_signal("score", score)

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

func change_color(color: Color, time, is_fix: bool = false) -> void:
	tween.remove_all()
	var trans_type := Tween.TRANS_LINEAR
	var ease_type := Tween.EASE_IN
	# platform color
	var start_color: Color = ($CSGCylinder.material as SpatialMaterial).albedo_color
	# tween.interpolate_property($CSGCylinder, "material:albedo_color", \
	#	start_color, color, time, trans_type, ease_type)
	($CSGCylinder.material as SpatialMaterial).albedo_color = color
	# light color
	tween.interpolate_property($OmniLight, "light_color", \
		$OmniLight.light_color, color, time, trans_type, ease_type)
	# label color & timing
	for label in [fix_lbl, fix_time_lbl, text_lbl, time_lbl]:
		tween.interpolate_property(label, "modulate", \
			label.modulate, color, time, trans_type, ease_type)
	if not is_fix:
		tween.interpolate_method(self, "set_timeing_label", time, 0.0, \
		time, trans_type, ease_type)
	tween.start()

func start_objective() -> void:
	text_lbl.text = "Fix me!"
	$objective_timer.start()
	change_color(ColorN("red"), objective_time)

func start_fix(start: bool):
	fix_lbl.visible = start
	tween_fix.remove_all()
	if start:
		$fix_timer.start()
		change_color(ColorN("green"), fix_time, true)
		tween_fix.interpolate_method(self, "set_fix_label", fix_time, 0.0, \
			fix_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween_fix.start()
	else:
		$fix_timer.stop()
		change_color(ColorN("red"), $objective_timer.time_left)

func start_cooldown() -> void:
	text_lbl.text = "Cooling down!"
	$cooldown_timer.start()
	change_color(ColorN("yellow"), cooldown_time)

func set_timeing_label(_time: float) -> void:
	time_lbl.text = "%.0f" % _time

func set_fix_label(_time: float) -> void:
	fix_time_lbl.text = "%.0f" % _time

