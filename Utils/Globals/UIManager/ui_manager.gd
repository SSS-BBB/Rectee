### UI Manager -> manage anything related to ui. Ex. Dialog
extends Node

# Class variables
var dialog: Dialog

# Class functions
func show_dialog_ui(dialog_data: Array[DialogData]):
	get_tree().paused = true
	dialog.show_dialog(dialog_data)
	await dialog.finished_dialog
	get_tree().paused = false
