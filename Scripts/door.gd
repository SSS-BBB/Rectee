class_name Door extends Area2D

# Export variables
@export var keys_need: int = 1
@export var next_scene_path: String

# Component variables
@onready var e_texture = $ETexture as Control
@onready var animation_player = $AnimationPlayer as AnimationPlayer

# Class varibles
var is_player_in: bool # is player around the door area

# Signals
signal enter_door

# Game functions
func _input(event):
	if event.is_action_pressed("interact") and is_player_in:
		e_texture.visible = false
		var player = get_tree().get_first_node_in_group("player") as Player
		if player.keys >= keys_need:
			enter_door.emit()
		else:
			animation_player.play("shake")

# Signal functions
func _on_body_entered(body: CharacterBody2D):
	if body.is_in_group("player"):
		e_texture.visible = true
		is_player_in = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		e_texture.visible = false
		is_player_in = false
