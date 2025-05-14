@tool
class_name PauseUI extends HudUI

# Game functions
func _ready():
	super._ready()
	UIManager.pause_ui = self


func _on_resume_button_button_down():
	MovementControlButton.do_action_input("pause_resume", self)
func _on_resume_button_button_up():
	MovementControlButton.do_action_released("pause_resume")

func _on_setting_button_pressed():
	# TODO: go to setting
	pass

func _on_quit_to_menu_button_pressed():
	# TODO: Are you sure you want to quit to main menu?
	# TODO: save current level
	# TODO: go to menu
	pass

func _on_exit_game_button_pressed():
	# TODO: Are you sure you want to exit the game?
	# TODO: save current level
	get_tree().quit()
