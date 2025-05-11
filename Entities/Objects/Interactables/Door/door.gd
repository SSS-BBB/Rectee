class_name Door extends Area2D

# Export variables
@export var keys_need: int = 1
@export var next_scence_path: String

# Component variables
@onready var e_control = $UIs/EControl as EControl
@onready var animation_player = $AnimationPlayer as AnimationPlayer
@onready var on_interact_component = $OnInteractComponent as OnInteractComponent

# Signals
signal enter_door

# Game functions
func _ready():
	on_interact_component.interact.connect(_on_interacted)

# Signal functions
func _on_interacted():
	e_control.visible = false
	var player = get_tree().get_first_node_in_group("player") as Player
	if player.keys >= keys_need:
		enter_door.emit()
	else:
		animation_player.play("shake")
