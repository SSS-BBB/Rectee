class_name ConfirmationButtonComponent extends Control

# Export variables
@export var confirm_button: Array[ConfirmationButtonData]
@export var button_container: Node


# Game functions
func _ready():
	if not confirm_button:
		push_error("No button loaded!")
		return
	
	for button in confirm_button:
		button.pressed.connect(_on_button_pressed.bind(button))

# Class functions
func set_buttons_activate_status(status: bool):
	# activate or deactivate all the buttons
	for child in button_container.get_children():
		if child is not Button:
			continue
		
		var button := child as Button
		button.disabled = not status

func reset_button_on_yes_button_pressed(on_yes_button_pressed: Callable):
	# reset button status after yes button is pressed, and then call the function
	set_buttons_activate_status(true)
	on_yes_button_pressed.call()

func reset_button_on_no_button_pressed(on_no_button_pressed: Callable):
	# reset button status after no button is pressed, and then call the function
	set_buttons_activate_status(true)
	on_no_button_pressed.call()

# Signal functions
func _on_button_pressed(button: ConfirmationButtonData):
	if not button.visible:
		return
	
	UIManager.show_confirmation_ui(tr(button.topic_text), tr(button.confirm_text), reset_button_on_yes_button_pressed.bind(button.on_yes_button_pressed), reset_button_on_no_button_pressed.bind(button.on_no_button_pressed))
	set_buttons_activate_status(false)
