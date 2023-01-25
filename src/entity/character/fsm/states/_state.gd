extends Node
class_name _State

var player = null
var state_type


signal change_state(_state)

func init(_player, _state_type) -> _State:
	player = _player
	state_type = _state_type

	return self

func enter() -> void:
	pass

func exit() -> void:
	pass

func physics_process(delta: float) -> void:
	pass

func process(delta: float) -> void:
	pass

func _on_player_anim_finished(anim_name: String) -> void:
	pass
