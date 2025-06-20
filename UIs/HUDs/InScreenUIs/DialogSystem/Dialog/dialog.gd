@tool
class_name Dialog extends HudUI

# Export variables
@export var dialog_speaker: TextureRect
@export var dialog_text: RichTextLabel
@export var next_button: Button

# Class variables
var typing: bool
var tween: Tween

# Signals
signal next_dialog
signal finished_dialog

# Game functions
func _ready():
	super._ready()
	
	if not Engine.is_editor_hint():
		UIManager.dialog = self
		typing = false

func _input(event):
	if event.is_action_pressed("next"):
		if typing:
			tween.stop()
			dialog_text.visible_ratio = 1.0
			typing = false
		else:
			next_dialog.emit()

# Class functions
func show_dialog(dialog_data: Array[DialogData]):
	# starts showing dialog
	visible = true
	for data in dialog_data:
		dialog_speaker.texture = data.speaker
		dialog_text.text = data.text
		
		# typing animation
		typing = true
		tween = get_tree().create_tween()
		tween.tween_property(dialog_text, "visible_ratio", 1.0, data.text_typing_duration).from(0.0)
		tween.tween_callback(func(): typing = false)
		tween.bind_node(self)
		
		await next_dialog
	
	# finished dialogs
	visible = false
	finished_dialog.emit()
