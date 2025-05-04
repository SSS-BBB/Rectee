# GameManger
extends Node

# Component variables
@onready var door_audio = $DoorAudio as AudioStreamPlayer

# Class variables
var current_box_level: int

# Class functions
func play_door_audio():
	door_audio.play()
