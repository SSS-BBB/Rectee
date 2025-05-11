class_name Key extends Area2D

func _on_body_entered(body: CharacterBody2D):
	if body.is_in_group("player"):
		var player = body as Player
		player.keys += 1
		call_deferred("queue_free")
