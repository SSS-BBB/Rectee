@tool
class_name PauseUI extends HudUI

# Component variables
@export var button_container: Control

# Class variables
var is_confirming: bool # the button will not do anything if confirmation ui is still on

# Game functions
func _ready():
	super._ready()
	
	if not Engine.is_editor_hint():
		UIManager.pause_ui = self
		is_confirming = false

func _input(event):
	if event.is_action_pressed("restart"):
		if can_button_be_pressed():
			_on_restart_button_pressed()

# Class functions
func can_button_be_pressed():
	return visible and not is_confirming

func set_buttons_activate_status(status: bool):
	# activate or deactivate all the buttons
	for child in button_container.get_children():
		var button := child as Button
		button.disabled = not status

func show_confirmation(topic_text: String, confirm_text: String, on_yes_button_pressed: Callable, on_no_button_pressed: Callable = reset_ui):
	UIManager.show_confirmation_ui(topic_text, confirm_text, on_yes_button_pressed, on_no_button_pressed)
	is_confirming = true
	set_buttons_activate_status(false)

func reset_ui():
	# reset when finsihed confirm dialog
	is_confirming = false
	set_buttons_activate_status(true)

# Signal functions

func _on_resume_button_button_down():
	if not can_button_be_pressed():
		return
	
	MovementControlButton.do_action_input("pause_resume", self)
	UIManager.current_hud_state = UIManager.HUDState.NONE
func _on_resume_button_button_up():
	MovementControlButton.do_action_released("pause_resume")

func _on_setting_button_pressed():
	if not can_button_be_pressed():
		return
	
	UIManager.show_setting_ui()

func _on_quit_to_menu_button_pressed():
	if not can_button_be_pressed():
		return
	
	show_confirmation(tr("[QuitToMenuConfirmationTitle]"), tr("[QuitToMenuConfirmation]"), 
		func():
			visible = false
			UIManager.exit_scene_transition(func(): get_tree().change_scene_to_file("res://UIs/Menus/MainMenu/main_menu.tscn"))
			reset_ui()
	)

func _on_exit_game_button_pressed():
	if not can_button_be_pressed():
		return
	
	show_confirmation(tr("[ExitConfirmationTitle]"), tr("[ExitGameConfirmation]"),
		func():
			reset_ui()
			get_tree().quit()
	)

func _on_restart_button_pressed():
	if not can_button_be_pressed():
		return
	
	show_confirmation(tr("[RestartConfirmationTitle]"), tr("[RestartConfirmation]"), 
		func():
			reset_ui()
			MovementControlButton.do_action_input("pause_resume", self)
			await UIManager.finished_pause_or_resume
			GameManager.reload_current_scene()
	)
