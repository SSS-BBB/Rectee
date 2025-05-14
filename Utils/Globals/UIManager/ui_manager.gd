### UI Manager -> manage anything related to ui. Ex. Dialog
extends Node

# Class variables
var dialog: Dialog
var pause_ui: PauseUI
var no_pause_inteferance: bool

# Game functions
func _input(event):
	if event.is_action_pressed("pause_resume"):
		pause_or_resume()

# Class functions
func show_dialog_ui(dialog_data: Array[DialogData]):
	if not dialog:
		push_error("No dialog ui loaded!")
		return
	
	get_tree().paused = true
	no_pause_inteferance = true
	dialog.show_dialog(dialog_data)
	await dialog.finished_dialog
	get_tree().paused = false
	no_pause_inteferance = false

func pause_or_resume():
	if not pause_ui:
		push_error("No pause ui loaded!")
		return
	
	if no_pause_inteferance:
		return
	
	get_tree().paused = not get_tree().paused
	pause_ui.visible = get_tree().paused
