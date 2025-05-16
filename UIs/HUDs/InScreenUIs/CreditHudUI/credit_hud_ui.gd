class_name CreditHudUI extends HudUI

# Class variables
var back_button_pressed_callback: Callable

# Signal functions
func _on_back_button_pressed():
	visible = false
	if back_button_pressed_callback:
		back_button_pressed_callback.call()
