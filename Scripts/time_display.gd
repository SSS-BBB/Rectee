class_name TimeDisplay extends Control
# TODO: Fix blurry label may be by changing font to some pixelate font

# Export variables
@export var to_hide: CanvasItem # node to hide when showing time

# Component variables
@onready var time_label = $TimeLabel as Label

# Class functions
func change_time(time: float):
	var round_time := snappedf(time, 0.01)
	time_label.text = str(round_time)
	check_display(time)

func check_display(time: float):
	if time > 0.0:
		visible = true
		if to_hide:
			to_hide.visible = false
	else:
		visible = false
