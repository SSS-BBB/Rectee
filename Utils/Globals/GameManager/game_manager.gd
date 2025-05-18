### GameManger -> manage scene logics ex. changing, reloading scene
extends Node

# Export variables
@export var init_box_scene: PackedScene

# Statics
enum Language { en, th }

# Class variables
var box_container: LevelBoxContainer
var current_box_level: int
var current_player_level: int = 2 # TODO: load from save
var current_box_scene: PackedScene
var language: Language = Language.en:
	set(value):
		language = value
		# TODO: change language
		print("Select ", language)
		# TODO: save setting

# Game functions
func _ready():
	# TODO: load language setting
	pass

# Class functions
func change_box_scene(new_box_scene: PackedScene):
	if not box_container:
		push_error("No Level Box Container in this scene!")
		return
	
	current_box_scene = new_box_scene
	box_container.change_box(new_box_scene)

func reload_current_scene():
	if not box_container:
		push_error("No Level Box Container in this scene!")
		return
	
	box_container.reload_box(current_box_scene)
