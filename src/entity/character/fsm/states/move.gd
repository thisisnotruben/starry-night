extends _State
class_name Move

export var max_speed = 10
export var acceleration = 70
export var friction = 60
export var air_friction = 10
export var gravity = -40
export var jump_impulse = 20
export var rot_speed = 5

var velocity = Vector3.ZERO
var snap_vector = Vector3.ZERO

var camera_spring_arm: SpringArm = null
var pivot: Spatial = null


func init(_player, _state_type) -> _State:
	.init(_player, _state_type)
	camera_spring_arm = _player.camera_arm
	pivot = _player.get_node("RootNode")
	return self

func enter() -> void:
	self.player.anim.play("walking_anim")

func physics_process(delta: float) -> void:
	var input_vector = get_input_vector()
	var direction = get_direction(input_vector)
	apply_movement(input_vector, direction, delta)
	apply_friction(direction, delta)
	apply_gravity(delta)
	camera_spring_arm.rotation.x = clamp(camera_spring_arm.rotation.x, deg2rad(-75), deg2rad(75))
	velocity = player.move_and_slide_with_snap(velocity, snap_vector, Vector3.UP, true, 4, 0.785398, false)

func get_input_vector() -> Vector3:
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("left") - Input.get_action_strength("right")
	input_vector.z = Input.get_action_strength("forward") - Input.get_action_strength("back")
	if input_vector.length() > 1.0:
		return input_vector.normalized()
	return input_vector

func get_direction(input_vector: Vector3) -> Vector3:
	return (input_vector.x * self.player.transform.basis.x) \
		+ (input_vector.z * self.player.transform.basis.z)

func apply_movement(input_vector: Vector3, direction: Vector3, delta: float):
	if direction != Vector3.ZERO:
		velocity.x = velocity.move_toward(direction * max_speed, acceleration * delta).x
		velocity.z = velocity.move_toward(direction * max_speed, acceleration * delta).z
		pivot.rotation.y = \
			lerp_angle(pivot.rotation.y, atan2(input_vector.x, input_vector.z), rot_speed * delta)

func apply_friction(direction: Vector3, delta: float) -> void:
	if direction == Vector3.ZERO:
		if player.is_on_floor():
			velocity = velocity.move_toward(Vector3.ZERO, friction * delta)
		else:
			velocity.x = velocity.move_toward(Vector3.ZERO, air_friction * delta).x
			velocity.z = velocity.move_toward(Vector3.ZERO, air_friction * delta).z

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, gravity, jump_impulse)
