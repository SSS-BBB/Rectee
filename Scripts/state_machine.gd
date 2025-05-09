class_name StateMachine extends Node

# Class variables
var current_state: State

# Game functions
func _process(delta):
	if current_state:
		current_state.update(delta)
		

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

# Class functions
func change_state(new_state: State):
	if current_state:
		current_state.exit_state()
	
	current_state = new_state
	new_state.enter_state()
