### UI Manager -> manage anything related to ui. Ex. Dialog
extends Node

# Statics
enum PausingState { NONE, PAUSE, DIALOG }

# Class variables
var pause_ui: PauseUI
var dialog: Dialog
var confirmation_ui: ConfirmationUI

var current_pausing_state: PausingState

# Signal
signal finished_pause_or_resume

# Game functions
func _ready():
	current_pausing_state = PausingState.NONE # None means the game is not pausing

func _input(event):
	if event.is_action_pressed("pause_resume"):
		pause_or_resume()

# Class functions
func show_dialog_ui(dialog_data: Array[DialogData]):
	if not dialog:
		push_error("No dialog ui loaded!")
		return
	
	if current_pausing_state != PausingState.NONE:
		push_warning("Trying to show dialog while the game is being paused.")
		return
	
	get_tree().paused = true
	current_pausing_state = PausingState.DIALOG
	
	dialog.show_dialog(dialog_data)
	await dialog.finished_dialog
	
	get_tree().paused = false
	current_pausing_state = PausingState.NONE

func pause_or_resume():
	if not pause_ui:
		push_error("No pause ui loaded!")
		return
	
	if current_pausing_state != PausingState.NONE and current_pausing_state != PausingState.PAUSE:
		push_warning("Trying to pause or resume, but the game is on another pausing state")
		return
	
	get_tree().paused = not get_tree().paused
	pause_ui.visible = get_tree().paused
	current_pausing_state = PausingState.PAUSE if get_tree().paused else PausingState.NONE
	finished_pause_or_resume.emit()

func show_confirmation_ui(topic_text: String, confirm_text: String, on_yes_button_pressed: Callable, on_no_button_pressed: Callable = func(): pass):
	if not confirmation_ui:
		push_error("No confirmation ui loaded!")
		return
	
	confirmation_ui.show_confirm_ui(topic_text, confirm_text, on_yes_button_pressed, on_no_button_pressed)
	
	
	
	
