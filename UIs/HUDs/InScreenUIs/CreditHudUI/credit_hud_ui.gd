class_name CreditHudUI extends HudUI

# Class variables
var back_button_pressed_callback: Callable

# Gmae functions
func _ready():
	super._ready()
	
	_on_language_changed()
	GameManager.language_changed.connect(_on_language_changed)

# Signal functions
func _on_language_changed():
	$CanvasLayer/BackgroundRect/CreditTitleLabel.text = tr("[CreditTitleLabel]")
	$CanvasLayer/BackgroundRect/VBoxContainer/ArtCreditLabel.text = tr("[ArtCreditLabel]")
	$CanvasLayer/BackgroundRect/VBoxContainer/SoundCreditLabel.text = tr("[SoundCreditLabel]")
	$CanvasLayer/BackgroundRect/VBoxContainer/ProgrammingCreditLabel.text = tr("[ProgrammingCreditLabel]")
	$CanvasLayer/BackgroundRect/LinkLabel.text = tr("[LinkLabel]")

func _on_back_button_pressed():
	visible = false
	if back_button_pressed_callback:
		back_button_pressed_callback.call()
