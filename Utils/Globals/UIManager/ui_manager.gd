### UI Manager -> manage anything related to ui. Ex. Dialog
extends Node

# Statics
enum HUDState { NONE, PAUSE, SETTING, CONFIRMATION, DIALOG, DIED }

# Class variables
var scene_transition: SceneTransition
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
		GameManager.save_setting("MovementUI", value)

var previous_hud_state: HUDState
var current_hud_state: HUDState
var is_scene_transitioning: bool

# Signal
signal finished_pause_or_resume
signal movement_control_setting_changed(on: bool)

# Game functions
func _ready():
	reset_hud_state_to_none()
	turn_movement_control_ui = GameManager.setting_data.MovementUI
	is_scene_transitioning = false

func _input(event):
	if event.is_action_pressed("pause_resume"):
		if (current_hud_state == HUDState.NONE or current_hud_state == HUDState.PAUSE) and not is_scene_transitioning:
			pause_or_resume()

# Class functions
func enter_scene_transition(on_exit_callback: Callable = func(): pass):
	is_scene_transitioning = true
	scene_transition.visible = true
	scene_transition.enter_scene()
	await scene_transition.enter_transition_finished
	on_exit_callback.call()
	is_scene_transitioning = false

func exit_scene_transition(on_exit_callback: Callable = func(): pass):
	is_scene_transitioning = true
	scene_transition.visible = true
	scene_transition.exit_scene()
	await scene_transition.exit_transition_finished
	on_exit_callback.call()
	is_scene_transitioning = false

func show_dialog_ui(dialog_data: Array[DialogData]):
	if not dialog:
		push_error("No dialog ui loaded!")
		return
	
	if current_hud_state != HUDState.NONE:
		push_warning("Trying to show dialog while the game is being paused.")
		return
	
	get_tree().paused = true
	current_hud_state = HUDState.DIALOG
	
	dialog.show_dialog(dialog_data)
	await dialog.finished_dialog
	
	get_tree().paused = false
	current_hud_state = HUDState.NONE

func set_hud_state(new_state: HUDState):
	previous_hud_state = current_hud_state
	current_hud_state = new_state

func reset_hud_state():
	var swap_state = previous_hud_state
	previous_hud_state = current_hud_state
	current_hud_state = swap_state

func reset_hud_state_to_none():
	previous_hud_state = HUDState.NONE
	current_hud_state = HUDState.NONE

func pause_or_resume():
	if not pause_ui:
		push_error("No pause ui loaded!")
		return
	
	get_tree().paused = not get_tree().paused
	pause_ui.visible = get_tree().paused
	set_hud_state(HUDState.PAUSE if get_tree().paused else HUDState.NONE)
	finished_pause_or_resume.emit()

func show_died_ui():
	if not died_ui:
		push_error("No died ui loaded!")
		return
	
	set_hud_state(HUDState.DIED)
	get_tree().paused = true
	died_ui.visible = true

func hide_died_ui():
	if not died_ui:
		push_error("No died ui loaded!")
		return
	
	died_ui.visible = false
	finished_pause_or_resume.emit()
	get_tree().paused = false
	set_hud_state(HUDState.NONE)

func show_confirmation_ui(topic_text: String, confirm_text: String, on_yes_button_pressed: Callable, on_no_button_pressed: Callable = func(): pass):
	if not confirmation_ui:
		push_error("No confirmation ui loaded!")
		return
	
	set_hud_state(HUDState.CONFIRMATION)
	confirmation_ui.show_confirm_ui(topic_text, confirm_text, on_yes_button_pressed, on_no_button_pressed)

func show_setting_ui(on_ok_pressed: Callable = func(): pass):
	if not setting_ui:
		push_error("No setting ui loaded!")
		return
	
	set_hud_state(HUDState.SETTING)
	
	setting_ui.visible = true
	setting_ui.on_ok_pressed = on_ok_pressed
