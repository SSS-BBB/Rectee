class_name CameraSnapArea extends Area2D

# Export variables
@export var camera: Camera2D
@export var snap_x: bool
@export var snap_y: bool
@export var x_camera_offset: Vector2 # left right offset
@export var y_camera_offset: Vector2 # top bottom offset
@export var target_group: String = "player"

# Component variables
@onready var collision_shape = $CollisionShape2D as CollisionShape2D

# Signal functions
func _on_body_exited(body: Node2D):
	if not body.is_in_group(target_group) or not camera:
		return
	
	# snap camera
	if snap_x:
		if body.global_position.x <= collision_shape.global_position.x:
			camera.offset.x = x_camera_offset.x
		else:
			camera.offset.x = x_camera_offset.y
	
	if snap_y:
		if body.global_position.y <= collision_shape.global_position.y:
			camera.offset.y = y_camera_offset.x
		else:
			camera.offset.y = y_camera_offset.y
