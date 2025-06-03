@tool
class_name ConfirmationUI extends HudUI

# Component variables
@export var topic_label: Label
@export var confirm_label: Label

# Class variables
var yes_func: Callable
var no_func: Callable

# Game functions
func _ready():
	super._ready()
	if not Engine.is_editor_hint():
		UIManager.confirmation_ui = self
		_on_language_changed()
		GameManager.language_changed.connect(_on_language_changed)

# Class functions
func show_confirm_ui(topic_text: String, confirm_text: String, on_yes_button_pressed: Callable, on_no_button_pressed: Callable = func(): pass):
	visible = true
	topic_label.text = topic_text
	confirm_label.text = confirm_text
	yes_func = on_yes_button_pressed
	no_func = on_no_button_pressed

# Signal functions
func _on_language_changed():
	$CanvasLayer/BackgroundRect/YesButton.text = tr("[Yes]")
	$CanvasLayer/BackgroundRect/NoButton.text = tr("[No]")

func _on_yes_button_pressed():
	visible = false
	yes_func.call()
	UIManager.current_hud_state = UIManager.HUDState.NONE

func _on_no_button_pressed():
	visible = false
	no_func.call()
	UIManager.current_hud_state = UIManager.HUDState.NONE
