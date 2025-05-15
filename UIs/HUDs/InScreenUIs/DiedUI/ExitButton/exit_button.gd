class_name ExitButton extends ConfirmationButtonData

# ConfirmationButtonData function
func on_yes_button_pressed():
	get_tree().quit()
