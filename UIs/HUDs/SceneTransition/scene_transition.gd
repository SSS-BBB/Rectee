class_name SceneTransition extends Control

# Export variables
@export var transition_time: float = 1.0

# Component variables
@onready var color_rect = $CanvasLayer/ColorRect as ColorRect

# Signals
signal exit_transition_finished

# Class functions
func enter_scene():
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "modulate:a", 0.0, transition_time / 2.0).from(1.0)
	
func exit_scene():
	# Audio
	GameManager.play_door_audio()
	
	# Fade
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, transition_time / 2.0).from(0.0)
	tween.tween_callback(func(): exit_transition_finished.emit())
