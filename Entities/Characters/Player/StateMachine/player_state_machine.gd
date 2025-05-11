class_name PlayerStateMachine extends StateMachine

# Export variables
@export var actor: CharacterBody2D

# Component variables
@onready var on_ground_state = $OnGroundState as State
@onready var on_air_state = $OnAirState as State


# Game functions
func _ready():
	if actor.is_on_floor():
		current_state = on_ground_state
	else:
		current_state = on_air_state
