class_name DialogData extends Resource

# Class variables
@export var speaker: Texture
@export var translate_text: bool = true
@export var text: String:
	get():
		if translate_text:
			return tr(text)
		return text
@export var text_typing_duration: float = 0.5
