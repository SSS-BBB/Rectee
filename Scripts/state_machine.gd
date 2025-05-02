class_name StateMachine extends Node2D

# Export variables
@export var actor: CharacterBody2D

# Component variables
@onready var on_ground_state = $OnGroundState as State
@onready var on_air_state = $OnAirState as State

# Class variables
var current_state: State

# Game functions
func _ready():
	if actor.is_on_floor():
		current_state = on_ground_state
	else:
		current_state = on_air_state
		

func _process(_delta):
	current_state.update()

# Class functions
func change_state(new_state: State):
	current_state.exit_state()
	current_state = new_state
	new_state.enter_state()
		
		
		
		
		
