class_name FallingPlatform extends Node2D

# Component variables
@onready var animation_player = $AnimationPlayer as AnimationPlayer

# Signal functions
func _on_fall_trigger_area_body_entered(body: CharacterBody2D):
	if body.is_in_group("player"):
		animation_player.play("fall")
		

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fall":
		call_deferred("queue_free")
