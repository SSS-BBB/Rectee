class_name SettingUI extends HudUI

# Export variables
@export var volume_slider: HSlider
@export var language_option_button: OptionButton
@export var movement_check_button: CheckButton

# Class variables
var on_ok_pressed: Callable

# Game functions
func _ready():
	super._ready()
	UIManager.setting_ui = self
	
	_on_language_changed()
	GameManager.language_changed.connect(_on_language_changed)

# Class functions
func select_language():
	match language_option_button.selected:
			0:
				GameManager.language = GameManager.Language.en
			1:
				GameManager.language = GameManager.Language.th
			_:
				push_warning("This language is not supported.")
				GameManager.language = GameManager.Language.en

# Signal functions
func _on_language_changed():
	$CanvasLayer/BackgroundRect/SettingLabel.text = tr("[SettingLabel]")
	$CanvasLayer/BackgroundRect/VolumeLabel.text = tr("[VolumeSettingLabel]")
	$CanvasLayer/BackgroundRect/LanguageLabel.text = tr("[LanguageSettingLabel]")
	language_option_button.set_item_text(0, tr("[en]"))
	language_option_button.set_item_text(1, tr("[th]"))
	$CanvasLayer/BackgroundRect/MovementLabel.text = tr("[MovementSettingLabel]")
	$CanvasLayer/BackgroundRect/OkButton.text = tr("[DoneSettingButton]")

func _on_ok_button_pressed():
	# set volume
	if volume_slider:
		AudioManager.volume_percentage = volume_slider.value
	else:
		push_warning("No volume slider object, cannot set volume")
	
	# set language
	if language_option_button:
		select_language()
	else:
		push_warning("No language option button object, cannot set language")
	
	# set movement button
	if movement_check_button:
		UIManager.turn_movement_control_ui = movement_check_button.button_pressed
	else:
		push_warning("No movement check button object, cannot set movement control ui")
	
	if on_ok_pressed:
		on_ok_pressed.call()
	
	UIManager.reset_hud_state()
	
	visible = false
