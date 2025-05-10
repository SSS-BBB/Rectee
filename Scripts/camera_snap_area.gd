class_name CameraSnapArea extends Node2D

# Export variables
@export var camera: Camera2D
@export var snap_x: bool
@export var snap_y: bool
@export var x_camera_position: Vector2 # left right offset
@export var y_camera_position: Vector2 # top bottom offset


# Signal functions
func _on_area_enter_component_target_enter_area(enter_to: AreaEnterComponent.EnterTo):
	if snap_x:
		match enter_to:
			AreaEnterComponent.EnterTo.LEFT:
				camera.global_position.x = x_camera_position.x
			AreaEnterComponent.EnterTo.RIGHT:
				camera.global_position.x = x_camera_position.y
	
	if snap_y:
		match enter_to:
			AreaEnterComponent.EnterTo.TOP:
				camera.global_position.y = y_camera_position.x
			AreaEnterComponent.EnterTo.BOTTOM:
				camera.global_position.y = y_camera_position.y
