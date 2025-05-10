@tool
class_name Consumable extends Area2D

# Export variables
@export var consumable_resource: ConsumableResource

# Component variables
@onready var sprite = $Sprite as Sprite2D

func _ready():
	if not Engine.is_editor_hint():
		sprite.texture = consumable_resource.texture

# Game functions
func _process(_delta):
	if Engine.is_editor_hint():
		sprite.texture = consumable_resource.texture

func _on_body_entered(body: CharacterBody2D):
	if body.is_in_group("player"):
		var player = body as Player
		var player_take_consumable := player.take_consumable(consumable_resource)
		if player_take_consumable:
			call_deferred("queue_free")
