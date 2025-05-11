class_name ShowOnEnterComponent extends Node2D

# Export variables
@export var to_show: CanvasItem
@export var enter_area: Area2D # show node when enter this area
@export var target_group: String = "player" # show node when this group enter

# Game functions
func _ready():
	if enter_area and to_show:
		enter_area.body_entered.connect(_show)
		enter_area.body_exited.connect(_hide)

# Signal functions
func _show(body: Node2D):
	if body.is_in_group(target_group):
		to_show.visible = true

func _hide(body: Node2D):
	if body.is_in_group(target_group):
		to_show.visible = false
