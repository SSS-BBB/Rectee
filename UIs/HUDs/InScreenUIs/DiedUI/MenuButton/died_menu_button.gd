class_name DiedMenuButton extends ConfirmationButtonData

# Export variables
@export var to_hide_when_exit: CanvasItem

# ConfirmationButtonData function
func on_yes_button_pressed():
	UIManager.exit_scene_transition(func(): get_tree().change_scene_to_file("res://UIs/Menus/MainMenu/main_menu.tscn"))
	if to_hide_when_exit:
		to_hide_when_exit.visible = false
