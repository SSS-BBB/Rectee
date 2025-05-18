class_name BoxCard extends Button

# Export variables
@export var box_card_data: BoxCardData

# Component variables
@onready var box_texture = $BoxTexture as TextureRect
@onready var box_label = $BoxLabel as Label

# Game functions
func _ready():
	if not box_card_data:
		push_error("No box card data loaded!")
		return
	
	# Disable if player current level is less than the box level
	if GameManager.current_player_level < box_card_data.box_level:
		disabled = true
		box_texture.texture = null
		box_label.text = ""
		return
	
	# Box Texture
	if box_card_data.box_texture:
		box_texture.texture = box_card_data.box_texture
	else:
		push_warning("Cannot show texture to this box card.")
	
	# Box Label
	if box_card_data.box_name:
		box_label.text = box_card_data.box_name
	else:
		push_warning("Cannot get name from this box card.")

# Signal functions
func _on_pressed():
	GameManager.init_box_scene = box_card_data.box_scene
	UIManager.exit_scene_transition(func(): get_tree().change_scene_to_file("res://Boxes/LevelBoxContainer/level_box_container.tscn"))
