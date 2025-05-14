class_name SceneTransition extends HudUI

# Export variables
@export var transition_time: float = 1.0

# Component variables
@onready var color_rect = $CanvasLayer/ColorRect as ColorRect


# Signals
signal enter_transition_finished
signal exit_transition_finished

# Statics
enum TransitionType { ENTER, EXIT }

# Class functions
func transition_prepare(transition_type: TransitionType):
	# Both transition prepare
	visible = true
	
	# Enter transition prepare
	if (transition_type == TransitionType.ENTER):
		color_rect.modulate.a = 1.0
		return
	
	# Exit transition prepare
	color_rect.modulate.a = 0.0

func transition_finished(transition_type: TransitionType):
	# Both transition finished
	visible = false
	
	# Enter transition finished
	if (transition_type == TransitionType.ENTER):
		enter_transition_finished.emit()
		return
	
	# Exit transition finished
	exit_transition_finished.emit()

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
