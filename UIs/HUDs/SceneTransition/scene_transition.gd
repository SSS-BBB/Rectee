class_name SceneTransition extends Control

# Export variables
@export var transition_time: float = 1.0
@export var to_hide_on_exit: Array[CanvasItem]
@export var hide_layer: int = -10 # hide this when not in transition
@export var show_layer: int = 10 # show this when in transition

# Component variables
@onready var canvas_layer = $CanvasLayer as CanvasLayer
@onready var color_rect = $CanvasLayer/ColorRect as ColorRect


# Signals
signal enter_transition_finished
signal exit_transition_finished

# Statics
enum TransitionType { ENTER, EXIT }

# Game functions
func _ready():
	pass

# Class functions
func transition_prepare(transition_type: TransitionType):
	# Both transition prepare
	canvas_layer.layer = show_layer
	
	# Enter transition prepare
	if (transition_type == TransitionType.ENTER):
		color_rect.modulate.a = 1.0
		return
	
	# Exit transition prepare
	color_rect.modulate.a = 0.0
	
	# hide before animating
	for to_hide in to_hide_on_exit:
		if not to_hide:
			continue
		to_hide.visible = false

func transition_finished(transition_type: TransitionType):
	# Both transition finished
	canvas_layer.layer = hide_layer
	
	# Enter transition finished
	if (transition_type == TransitionType.ENTER):
		enter_transition_finished.emit()
		return
	
	# Exit transition finished
	exit_transition_finished.emit()
	
	# show after animating
	for to_hide in to_hide_on_exit:
		if not to_hide:
			continue
		to_hide.visible = true

func enter_scene():
	transition_prepare(TransitionType.ENTER)
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "modulate:a", 0.0, transition_time / 2.0).from(1.0)
	tween.tween_callback(transition_finished.bind(TransitionType.ENTER))
	
func exit_scene():
	transition_prepare(TransitionType.EXIT)
	# Fade
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, transition_time / 2.0).from(0.0)
	tween.tween_callback(transition_finished.bind(TransitionType.EXIT))
