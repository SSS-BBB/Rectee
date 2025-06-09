class_name EndGameUI extends HudUI

# Game functions
func _ready() -> void:
	super._ready()
	UIManager.endgame_ui = self


# Signal functions
func _on_menu_button_pressed():
	UIManager.show_confirmation_ui(tr("[QuitToMenuConfirmationTitle]"), tr("[QuitToMenuConfirmation]"), go_to_menu)

func _on_exit_button_pressed():
	UIManager.show_confirmation_ui(tr("[ExitConfirmationTitle]"), tr("[ExitGameConfirmation]"), exit_game)

# Callback functions
func go_to_menu():
	UIManager.reset_hud_state_to_none()
	UIManager.exit_scene_transition(func(): get_tree().change_scene_to_file("res://UIs/Menus/MainMenu/main_menu.tscn"))
	visible = false

func exit_game():
	get_tree().quit()
