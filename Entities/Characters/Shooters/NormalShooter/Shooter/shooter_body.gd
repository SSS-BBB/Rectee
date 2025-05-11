class_name ShooterBody extends CharacterBody2D

# Export variables
@export var shooter_container: Shooter

# Component variables
@onready var ray_cast_container = $RayCastContainer as Node2D

# Signals
signal see_player

# Game functions
func _physics_process(delta: float):
	for child in ray_cast_container.get_children():
		if child is RayCast2D:
			check_ray(child, delta)
		
# Class functions
func check_ray(ray_cast: RayCast2D, delta: float):
	# check each ray cast in the raycast container
	var see_object := ray_cast.get_collider() as Node2D
	if see_object and see_object.is_in_group("player"):
		see_player.emit(see_object, delta)
		
		
		
