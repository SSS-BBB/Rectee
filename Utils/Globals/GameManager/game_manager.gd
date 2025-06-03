### GameManger -> manage scene logics ex. changing, reloading scene
extends Node

# Export variables
@export var init_box_scene: PackedScene

# Statics
const SAVE_SETTINGS_LOCATION: String = "user://rectee_settings.json"
const SAVE_GAME_DATAS_LOCATION: String = "user://game_data.json"
enum Language { en, th }

# Signals
signal language_changed

# Class variables
var box_container: LevelBoxContainer
var current_box_level: int
var current_player_level: int = 2:
	set(value):
		current_player_level = value
		# TODO: change init box scene
		save_game("CurrentPlayerLevel", value)
var current_box_scene: PackedScene
var language: Language = Language.en:
	set(value):
		language = value
		set_localization()
		language_changed.emit()
		save_setting("Language", value)

var setting_data: Dictionary = {
	"VolumePercentage": 1.0,
	"Language": Language.en,
	"MovementUI": true
}
var game_data: Dictionary = {
	"CurrentPlayerLevel": 1
}

# Game functions
func _ready():
	# Load datas
	load_setting()
	load_game_data()
	
	# Set data from save
	language = setting_data.Language
	current_player_level = game_data.CurrentPlayerLevel

# Class functions
func set_localization():
	match language:
		Language.en:
			TranslationServer.set_locale("en")
		Language.th:
			TranslationServer.set_locale("th")
		_:
			push_warning("This game does not support this language!")

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

func save_setting(to_save: String, value):
	var save_file = FileAccess.open(SAVE_SETTINGS_LOCATION, FileAccess.WRITE)
	setting_data[to_save] = value
	save_file.store_var(setting_data.duplicate())
	save_file.close()

func save_game(to_save: String, value):
	var save_file := FileAccess.open(SAVE_GAME_DATAS_LOCATION, FileAccess.WRITE)
	game_data[to_save] = value
	save_file.store_var(game_data.duplicate())
	save_file.close()

func load_setting():
	if FileAccess.file_exists(SAVE_SETTINGS_LOCATION):
		var file := FileAccess.open(SAVE_SETTINGS_LOCATION, FileAccess.READ)
		var save_data = file.get_var()
		file.close()
		
		var new_setting_data = save_data.duplicate()
		setting_data.VolumePercentage = new_setting_data.VolumePercentage
		setting_data.Language = new_setting_data.Language
		setting_data.MovementUI = new_setting_data.MovementUI

func load_game_data():
	if FileAccess.file_exists(SAVE_GAME_DATAS_LOCATION):
		var file := FileAccess.open(SAVE_GAME_DATAS_LOCATION, FileAccess.READ)
		var save_data = file.get_var()
		file.close()
		
		var new_game_data = save_data.duplicate()
		game_data.CurrentPlayerLevel = new_game_data.CurrentPlayerLevel
