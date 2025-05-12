### GameManger
extends Node

# Export variables
@export var init_box_scene: PackedScene

# Component variables
@onready var door_audio = $DoorAudio as AudioStreamPlayer

# Signals
signal box_scene_chaged(new_box_scene: PackedScene)

# Class variables
var current_box_level: int
var current_box_scene: PackedScene:
	set(value):
		current_box_scene = value
		box_scene_chaged.emit(current_box_scene)

# Class functions
func play_door_audio():
	door_audio.play()
