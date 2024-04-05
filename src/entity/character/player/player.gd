extends KinematicBody
class_name Player

onready var anim: AnimationPlayer = $RootNode/AnimationPlayer
onready var camera_arm := $SpringArm
onready var ray_cast := $RayCast
onready var fall_timer := $fall_timer

var fsm = Fsm.new()
var is_falling := false

signal player_fell(won, fell)


func _ready() -> void:
	add_child(fsm.init(self))
	fsm.change_state(StateType.States.IDLE)

func _physics_process(delta: float) -> void:
	fsm.physics_process(delta)
	
	var state = StateType.States.IDLE
	if Input.get_vector("left", "right", "forward", "back").length() > 0.0:
		state = StateType.States.MOVE
	elif Input.is_action_pressed("tool"):
		state = StateType.States.TOOL
	elif Input.is_action_pressed("victory"):
		state = StateType.States.VICTORY
	elif Input.is_action_pressed("defeat"):
		state = StateType.States.DEFEAT
	if state != -1:
		fsm.change_state(state)

func _process(delta) -> void:
	fsm.process(delta)
	if not ray_cast.is_colliding():
		fsm.change_state(StateType.States.FALL)
		if not is_falling:
			fall_timer.start()
		is_falling = true

func _on_fall_timer_timeout() -> void:
	emit_signal("player_fell", false, true)
