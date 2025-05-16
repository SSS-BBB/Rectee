class_name PlayButton extends Button

func _ready():
	if GameManager.current_player_level <= 1:
		text = "[PlayButton]"
	else:
		text = "[ContinueButton]"
