@tool
class_name FallingSpikeHitBox extends SpikeHitbox


# Override functions
func get_collision_angle() -> float:
	return -(PI/2 - atan2(sprite_height / 2.0, sprite_width / 4.0))

func get_collision_offset(horizontal_direction: Vector2) -> Vector2:
	return 0.6*horizontal_direction + Vector2.DOWN
	
func _on_area_2d_body_entered(body):
	super._on_area_2d_body_entered(body)
	
	# destroying spike after it hit anything
	spike.call_deferred("queue_free")
