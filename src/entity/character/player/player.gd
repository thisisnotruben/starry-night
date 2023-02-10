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


func _physics_process(delta) -> void:
	fsm.physics_process(delta)

func _process(delta) -> void:
	fsm.process(delta)
	if not ray_cast.is_colliding():
		fsm.change_state(StateType.States.FALL)
		if not is_falling:
			fall_timer.start()
		is_falling = true

func _input(event: InputEvent) -> void:
	var state = -1

	if event.is_action_pressed("left", true) \
	or event.is_action_pressed("right", true) \
	or event.is_action_pressed("forward", true) \
	or event.is_action_pressed("back", true):
		state = StateType.States.MOVE
	elif event.is_action_released("left") or \
	event.is_action_released("right") \
	or event.is_action_released("forward") \
	or event.is_action_released("back"):
		state = StateType.States.IDLE
	elif event.is_action("tool"):
		state = StateType.States.TOOL
	elif event.is_action("victory"):
		state = StateType.States.VICTORY
	elif event.is_action("defeat"):
		state = StateType.States.DEFEAT

	if state != -1:
		fsm.change_state(state)

func _on_fall_timer_timeout() -> void:
	emit_signal("player_fell", false, true)
