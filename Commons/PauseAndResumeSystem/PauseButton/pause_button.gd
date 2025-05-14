@tool
class_name PauseButton extends HudUI

func _on_button_button_down():
	MovementControlButton.do_action_input("pause_resume", self)


func _on_button_button_up():
	MovementControlButton.do_action_released("pause_resume")
