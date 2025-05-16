### UI Manager -> manage anything related to ui. Ex. Dialog
extends Node

# Statics
enum PausingState { NONE, PAUSE, DIALOG, DIED }

# Class variables
var pause_ui: PauseUI
var dialog: Dialog
var confirmation_ui: ConfirmationUI
var died_ui: DiedUI
var setting_ui: SettingUI
var turn_movement_control_ui: bool = true:
	 # turn movement control ui on/off
	set(value):
		turn_movement_control_ui = value
		movement_control_setting_changed.emit(turn_movement_control_ui)

var current_pausing_state: PausingState

# Signal
signal finished_pause_or_resume
signal movement_control_setting_changed(on: bool)

# Game functions
func _ready():
	current_pausing_state = PausingState.NONE # None means the game is not pausing

func _input(event):
	if event.is_action_pressed("pause_resume"):
		if current_pausing_state == PausingState.NONE or current_pausing_state == PausingState.PAUSE:
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
	
	get_tree().paused = not get_tree().paused
	pause_ui.visible = get_tree().paused
	current_pausing_state = PausingState.PAUSE if get_tree().paused else PausingState.NONE
	finished_pause_or_resume.emit()

func show_died_ui():
	if not died_ui:
		push_error("No died ui loaded!")
		return
	
	if current_pausing_state != PausingState.NONE:
		push_warning("Trying to show died ui, while the game is being paused.")
		return
	
	get_tree().paused = true
	current_pausing_state = PausingState.DIED
	
	died_ui.visible = true

func hide_died_ui():
	if not died_ui:
		push_error("No died ui loaded!")
		return
	
	if current_pausing_state != PausingState.DIED:
		push_warning("Trying to hide died ui, when there is no died ui being shown.")
		return
	
	died_ui.visible = false
	finished_pause_or_resume.emit()
	get_tree().paused = false
	current_pausing_state = PausingState.NONE

func show_confirmation_ui(topic_text: String, confirm_text: String, on_yes_button_pressed: Callable, on_no_button_pressed: Callable = func(): pass):
	if not confirmation_ui:
		push_error("No confirmation ui loaded!")
		return
	
	confirmation_ui.show_confirm_ui(topic_text, confirm_text, on_yes_button_pressed, on_no_button_pressed)

func show_setting_ui():
	if not setting_ui:
		push_error("No setting ui loaded!")
		return

	setting_ui.visible = true
