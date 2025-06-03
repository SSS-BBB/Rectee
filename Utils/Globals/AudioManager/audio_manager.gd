### AudioManager -> manage audios (no shit sherlock)
extends Node

# Component variables
@onready var door_audio = $DoorAudio as AudioStreamPlayer

# Class variables
var bus_index: int

var volume_percentage: float:
	set(value):
		volume_percentage = value
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(volume_percentage))
		GameManager.save_setting("VolumePercentage", value)

# Game functions
func _ready():
	bus_index = AudioServer.get_bus_index("Master")
	volume_percentage = GameManager.setting_data.VolumePercentage
	
# CLass functions
func play_door_audio():
	door_audio.play()
