class_name EControl extends Control


func _on_e_button_pressed():
	MovementControlButton.do_action_input("interact", self)
