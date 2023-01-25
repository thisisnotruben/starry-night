extends Node
class_name Fsm

var states: Dictionary = {}
var _prev_state: _State = null
var _curr_state: _State = null

# _state: States (enum)
signal state_changed(_state)


func init(_player) -> void:
	states = {
		StateType.States.MOVE: Move.new(),
		StateType.States.IDLE: Idle.new(),
		StateType.States.TOOL: Tool.new(),
		StateType.States.VICTORY: Victory.new(),
		StateType.States.DEFEAT: Defeat.new(),
		StateType.States.DEATH: Death.new()
	}
	for state in states:
		var _state = states[state].init(_player, state)
		add_child(_state)
		_state.connect("change_state", self, "change_state")
		_player.anim.connect("animation_finished", states[state], "_on_player_anim_finished")

# _state: States (enum)
func change_state(_state) -> void:
	if _state == null or (_curr_state != null \
	and _curr_state.state_type == _state):
		return
	if _curr_state != null:
		_curr_state.exit()
	states[_state].enter()
	_prev_state = _curr_state
	_curr_state = states[_state]
	emit_signal("state_changed", _state)

func physics_process(delta: float) -> void:
	 _curr_state.physics_process(delta)

func process(delta: float) -> void:
	_curr_state.process(delta)

func input(event: InputEvent) -> void:
	_curr_state.input(event)
