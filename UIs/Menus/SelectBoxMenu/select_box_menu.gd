class_name SelectBoxMenu extends Control

# Game functions
func _ready():
	get_tree().paused = false
	UIManager.current_pausing_state = UIManager.PausingState.NONE

# Signal functions
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://UIs/Menus/MainMenu/main_menu.tscn")
