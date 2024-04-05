extends Node
class_name _State

var player = null
var state_type
var fsm


signal change_state(_state)

func init(args := {}) -> _State:
	player = args["player"]
	state_type = args["state_type"]
	fsm = args["fsm"]
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
