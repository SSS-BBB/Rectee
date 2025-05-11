class_name EControl extends Control


func _on_e_button_pressed():
	if not visible:
		return
		
	var interact_event = InputEventAction.new()
	interact_event.action = "interact"
	interact_event.pressed = true
	Input.parse_input_event(interact_event)
