class_name SceneTransition extends Control

# Export variables
@export var transition_time: float = 1.0
@export var canvas_layer_to_hide: Array[CanvasLayer]

# Component variables
@onready var color_rect = $CanvasLayer/ColorRect as ColorRect

# Class variables
var original_layer: Array[int]

# Signals
signal exit_transition_finished

# Game functions
func _ready():
	for to_hide in canvas_layer_to_hide:
		original_layer.append(to_hide.layer)

# Class functions
func enter_scene():
	# Lower layer before setting it to the same layer after finsihed animating
	for to_hide in canvas_layer_to_hide:
		to_hide.layer = 0
	
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "modulate:a", 0.0, transition_time / 2.0).from(1.0)
	tween.tween_callback(reset_layer)
	
func exit_scene():
	# Lower layer canvas layer
	for to_hide in canvas_layer_to_hide:
		to_hide.layer = 0
	
	# Audio
	GameManager.play_door_audio()
	
	# Fade
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, transition_time / 2.0).from(0.0)
	tween.tween_callback(func(): exit_transition_finished.emit())

func reset_layer():
	for i in range(canvas_layer_to_hide.size()):
		canvas_layer_to_hide[i].layer = original_layer[i]
