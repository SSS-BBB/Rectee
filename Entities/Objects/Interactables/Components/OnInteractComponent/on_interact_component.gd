class_name OnInteractComponent extends Node2D

# Export variables
@export var area: Area2D
@export var target_group: String = "player"
@export var input_map_action: String = "interact"

# Signal
signal interact

# Class variables
var is_target_in_area: bool

# Game functions
func _ready():
	# area connect
	if not area:
		push_error("Could not find area to check for interaction")
		return
	is_target_in_area = false
	area.body_entered.connect(_on_body_enterd)
	area.body_exited.connect(_on_body_exited)

func _input(event):
	if event.is_action_pressed(input_map_action) and is_target_in_area:
		interact.emit()

# Signal functions
func _on_body_enterd(body: Node2D):
	if body.is_in_group(target_group):
		is_target_in_area = true

func _on_body_exited(body: Node2D):
	if body.is_in_group(target_group):
		is_target_in_area = false
