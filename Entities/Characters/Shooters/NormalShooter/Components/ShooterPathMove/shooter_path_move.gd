# Shooter movement with set path
class_name ShooterPathMove extends Path2D

# Export variables
@export var path_duration: float = 1.0
@export var loop: bool = false

# Components variables
@onready var path_follow = $PathFollow2D as PathFollow2D

# Class variables
var tween: Tween

# Class functions
func move():
	tween = get_tree().create_tween().set_loops()
	tween.tween_property(path_follow, "progress_ratio", 1.0, path_duration)
	if !loop:
		tween.tween_property(path_follow, "progress_ratio", 0.0, path_duration)
	else:
		tween.tween_property(path_follow, "progress_ratio", 0.0, 0.0)
	tween.bind_node(self)
		
func stop_move():
	if tween:
		tween.kill()
