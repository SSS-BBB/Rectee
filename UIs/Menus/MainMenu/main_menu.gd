class_name MainMenu extends Control

# Export variables
@export var level_scene_path: Array[String] # scene path for each level
@export var scene_transition: SceneTransition
@export var button_container: Control
@export var credit_hud_ui: CreditHudUI

# Game functions
func _ready():
	get_tree().paused = false
	UIManager.current_hud_state = UIManager.HUDState.NONE
	
	if scene_transition:
		scene_transition.enter_scene()
		await scene_transition.enter_transition_finished
		scene_transition.visible = false
		scene_transition.canvas_layer.visible = false
		scene_transition.canvas_layer.layer = scene_transition.to_hide_layer
	
	_on_lanuage_changed()
	GameManager.language_changed.connect(_on_lanuage_changed)

# Class functions
func set_buttons_status(status: bool):
	for child in button_container.get_children():
		if child is not Button:
			continue
		var button := child as Button
		button.disabled = not status

# Signal functions
func _on_lanuage_changed():
	if GameManager.current_player_level <= 1:
		$CanvasLayer/BackgroundRect/ButtonBoxContainer/PlayButton.text = tr("[PlayButton]")
	else:
		$CanvasLayer/BackgroundRect/ButtonBoxContainer/PlayButton.text = tr("[ContinueButton]")
	
	$CanvasLayer/BackgroundRect/GameTitleLabel.text = tr("[GameTitle]")
	$CanvasLayer/BackgroundRect/ButtonBoxContainer/SelectBoxButton.text = tr("[SelectBoxButton]")
	$CanvasLayer/BackgroundRect/ButtonBoxContainer/SettingButton.text = tr("[SettingButton]")
	$CanvasLayer/BackgroundRect/ButtonBoxContainer/CreditButton.text = tr("[CreditButton]")
	$CanvasLayer/BackgroundRect/ButtonBoxContainer/ExitButton.text = tr("[ExitButton]")

func _on_play_button_pressed():
	if level_scene_path and level_scene_path.size() > 0:
		var scene_path_index = (GameManager.current_player_level - 1) % level_scene_path.size()
		if not level_scene_path[scene_path_index].is_absolute_path():
			push_error("Scene path at index " + str(scene_path_index) + " is not in absolute path format.")
		else:
			GameManager.init_box_scene = load(level_scene_path[scene_path_index])
	else:
		push_error("No level scene path initialized!")
	
	# change scene
	if scene_transition:
		scene_transition.visible = true
		scene_transition.exit_scene()
		await scene_transition.exit_transition_finished
	else:
		push_warning("No scene transition in main menu.")
	
	get_tree().change_scene_to_file("res://Boxes/LevelBoxContainer/level_box_container.tscn")

func _on_select_box_button_pressed():
	get_tree().change_scene_to_file("res://UIs/Menus/SelectBoxMenu/select_box_menu.tscn")

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
	UIManager.show_confirmation_ui(tr("[ExitConfirmationTitle]"), tr("[ExitGameConfirmation]"), 
	func(): get_tree().quit(), set_buttons_status.bind(true)
	)

func _on_reset_level_button_pressed():
	GameManager.current_player_level = 3
