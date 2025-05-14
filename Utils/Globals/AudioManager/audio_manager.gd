### AudioManager -> manage audios (no shit sherlock)
extends Node

# Component variables
@onready var door_audio = $DoorAudio as AudioStreamPlayer

func play_door_audio():
	door_audio.play()
