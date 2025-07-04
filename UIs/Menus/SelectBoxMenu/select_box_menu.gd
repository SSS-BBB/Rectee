class_name SelectBoxMenu extends Control

# Game functions
func _ready():
	get_tree().paused = false
	UIManager.current_hud_state = UIManager.HUDState.NONE
	
	_on_language_changed()
	GameManager.language_changed.connect(_on_language_changed)

# Signal functions
func _on_language_changed():
	$SelectBoxTitleLabel.text = tr("[SelectBoxTitleLabel]")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://UIs/Menus/MainMenu/main_menu.tscn")
