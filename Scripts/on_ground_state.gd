class_name OnGroundState extends State

@export var state_machine: StateMachine
@export var landingAudio: AudioStreamPlayer2D
@export var next_state: State

func enter_state():
	landingAudio.play()
	
func exit_state():
	pass
	
func update(_delta: float):
	if not state_machine.actor.is_on_floor():
		state_machine.change_state(next_state)
