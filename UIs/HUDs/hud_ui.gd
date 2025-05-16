class_name HudUI extends Control

# Export variables
@export var canvas_layer: CanvasLayer
@export var to_show_layer: int = 10
@export var to_hide_layer: int = -10
@export var to_hide_on_activate: Array[CanvasItem]
@export var to_show_on_activate: Array[CanvasItem]
@export var always_hide: bool = false
@export var always_show: bool = false

# Game functions
func _ready():
	visibility_changed.connect(_on_visibility_changed)
	
	if always_hide:
		visible = false
	if always_show:
		visible = true

# Class functions
func hide_to_hide():
	for to_hide in to_hide_on_activate:
		to_hide.visible = false

func show_to_show():
	for to_show in to_show_on_activate:
		to_show.visible = true

func show_to_hide():
	for to_hide in to_hide_on_activate:
		to_hide.visible = true

func hide_to_show():
	for to_show in to_show_on_activate:
		to_show.visible = false

# Signal functions
func _on_visibility_changed():
	if not canvas_layer:
		return
	
	if always_show:
		visible = true
	
	if always_hide:
		visible = false
	
	canvas_layer.visible = visible
	if visible:
		canvas_layer.layer = to_show_layer
		# activate
		show_to_show()
		hide_to_hide()
	else:
		canvas_layer.layer = to_hide_layer
		# deactivate
		hide_to_show()
		show_to_hide()
