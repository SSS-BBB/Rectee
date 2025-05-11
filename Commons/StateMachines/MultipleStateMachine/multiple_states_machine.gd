class_name MultipleStatesMachine extends Node

# Export variables
@export var number_of_states: int = 0

# Class variables
var current_states_list: Array[State]

# Game functions
func _ready():
	current_states_list.resize(number_of_states)

func _process(delta):
	if not current_states_list:
		return

	for state in current_states_list:
		if state:
			state.update(delta)

func _physics_process(delta):
	if not current_states_list:
		return
	
	for state in current_states_list:
		if state:
			state.physics_update(delta)

# Class functions
func insert_state(index: int, state: State) -> bool:
	# cannot insert state to list
	if not current_states_list:
		return false
	if index < 0 or index >= current_states_list.size():
		return false
	
	# exit previous state
	if current_states_list[index]:
		current_states_list[index].exit_state()
	
	# insert
	current_states_list.insert(index, state)
	current_states_list[index].enter_state()
	return true

func remove_state(target_state: State) -> bool:
	if not current_states_list:
		return false
	
	for i in range(current_states_list.size()):
		if current_states_list[i] == target_state:
			current_states_list[i].exit_state()
			current_states_list.insert(i, null)
			return true
	
	return false

func remove_state_at_index(index: int) -> bool:
	# cannot insert state to list
	if not current_states_list:
		return false
	if index < 0 or index >= current_states_list.size():
		return false
	
	current_states_list[index].exit_state()
	current_states_list.insert(index, null)
	return true
