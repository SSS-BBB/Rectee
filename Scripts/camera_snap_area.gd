class_name CameraSnapArea extends Node2D

# Export variables
@export var camera: Camera2D
@export var snap_x: bool
@export var snap_y: bool
@export var x_camera_offset: Vector2 # left right offset
@export var y_camera_offset: Vector2 # top bottom offset


# Signal functions
func _on_area_enter_component_target_enter_area(enter_to: AreaEnterComponent.EnterTo):
	if snap_x:
		match enter_to:
			AreaEnterComponent.EnterTo.LEFT:
				camera.offset.x = x_camera_offset.x
			AreaEnterComponent.EnterTo.RIGHT:
				camera.offset.x = x_camera_offset.y
	
	if snap_y:
		match enter_to:
			AreaEnterComponent.EnterTo.TOP:
				camera.offset.y = y_camera_offset.x
			AreaEnterComponent.EnterTo.BOTTOM:
				camera.offset.y = y_camera_offset.y
