class_name OnAirState extends State

@export var state_machine: StateMachine
@export var next_state: State

func enter_state():
	pass
	
func exit_state():
	pass
	
func update(_delta: float):
	if state_machine.actor.is_on_floor():
		state_machine.change_state(next_state)
