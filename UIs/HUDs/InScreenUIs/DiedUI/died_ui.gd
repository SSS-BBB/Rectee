class_name DiedUI extends HudUI

# Game functions
func _ready():
	super._ready()
	UIManager.died_ui = self
