@tool
class_name MovingPlatform extends Path2D

# Export variables
@export var path_duration: float = 1.0
@export var loop: bool = false

# Components variables
@onready var path_follow = $PathFollow2D as PathFollow2D
@onready var platform_body = $AnimatableBody2D as AnimatableBody2D

# Game functions
func _ready():
	if Engine.is_editor_hint():
		return
	
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(path_follow, "progress_ratio", 1.0, path_duration)
	
	if !loop:
		tween.tween_property(path_follow, "progress_ratio", 0.0, path_duration)
	else:
		tween.tween_property(path_follow, "progress_ratio", 0.0, 0.0)
	
	tween.bind_node(self)

# Class functions
func get_body():
	if not platform_body:
		return null
	
	return platform_body
