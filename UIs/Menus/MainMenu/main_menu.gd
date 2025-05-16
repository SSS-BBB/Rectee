class_name MainMenu extends Control

# Export variables
@export var scene_transition: SceneTransition
@export var button_container: Control
@export var credit_hud_ui: CreditHudUI

# Game functions
func _ready():
	get_tree().paused = false
	UIManager.current_pausing_state = UIManager.PausingState.NONE
	
	if scene_transition:
		scene_transition.enter_scene()
		await scene_transition.enter_transition_finished
		scene_transition.visible = false
		scene_transition.canvas_layer.visible = false
		scene_transition.canvas_layer.layer = scene_transition.to_hide_layer

# Class functions
func set_buttons_status(status: bool):
	for child in button_container.get_children():
		if child is not Button:
			continue
		var button := child as Button
		button.disabled = not status

# Signal functions
func _on_play_button_pressed():
	# TODO: change box scene in game manager according to player current level
	
	# change scene
	if scene_transition:
		scene_transition.visible = true
		scene_transition.exit_scene()
		await scene_transition.exit_transition_finished
	else:
		push_warning("No scene transition in main menu.")
	
	get_tree().change_scene_to_file("res://Boxes/LevelBoxContainer/level_box_container.tscn")

func _on_select_box_button_pressed():
	# TODO: go to select box menu
	pass

func _on_setting_button_pressed():
	set_buttons_status(false)
	UIManager.show_setting_ui(set_buttons_status.bind(true))

func _on_credit_button_pressed():
	if not credit_hud_ui:
		push_error("No credit hud ui loaded in the main menu")
		return
	
	set_buttons_status(false)
	credit_hud_ui.visible = true
	credit_hud_ui.back_button_pressed_callback = set_buttons_status.bind(true)

func _on_exit_button_pressed():
	set_buttons_status(false)
	UIManager.show_confirmation_ui("[ExitTopic]", "[ExitGameConfirmation]", func(): get_tree().quit(), set_buttons_status.bind(true))
