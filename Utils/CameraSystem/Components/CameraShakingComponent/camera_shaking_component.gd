class_name CameraShakingComponent extends Node2D

# Export variables
@export var camera: Camera2D
@export var shake_force: float = 5.0

# Class functions
func shake_camera():
	if not camera:
		return
	
	camera.offset = Vector2(randf_range(-shake_force, shake_force), randf_range(-shake_force, shake_force))
