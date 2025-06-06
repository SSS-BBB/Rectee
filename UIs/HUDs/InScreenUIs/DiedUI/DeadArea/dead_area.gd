class_name DeadArea extends Area2D

# Signal functions
func _on_body_entered(body: Node2D):
	if not body.is_in_group("player"):
		return
	
	var player: Player = body as Player
	player._on_actor_die()
