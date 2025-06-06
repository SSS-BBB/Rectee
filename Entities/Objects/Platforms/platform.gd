class_name Platform extends Node2D

# Export variables
@export var platform_body: PhysicsBody2D

# Class functions
func get_body():
	if not platform_body:
		return null
	
	return platform_body
