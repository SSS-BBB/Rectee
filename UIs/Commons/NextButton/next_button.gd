class_name NextButton extends Button



# Signal functions
func _on_button_down():
	MovementControlButton.do_action_input("next", self)


func _on_button_up():
	MovementControlButton.do_action_released("next")
