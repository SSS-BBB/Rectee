class_name FallingMovement extends Node2D

# Export variables
@export var actor: PhysicsBody2D
@export_category("Movement")
@export var init_speed: float = 350.0
@export var acceleration: float = 150.0

# Class variables
var current_speed: float

# Game functions
func _ready():
	current_speed = init_speed

func _physics_process(delta):
	# update speed
	current_speed += acceleration * delta
	
	# update position
	actor.position.y += current_speed * delta
