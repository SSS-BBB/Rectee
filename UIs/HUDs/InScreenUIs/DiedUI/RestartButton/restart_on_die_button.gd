class_name RestartOnDieButton extends Button

func _on_pressed():
	if not visible:
		return
	
	UIManager.hide_died_ui()
	GameManager.reload_current_scene()
