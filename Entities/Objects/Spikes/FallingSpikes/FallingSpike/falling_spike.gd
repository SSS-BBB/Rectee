@tool
class_name FallingSpike extends Spike

# Override functions
func set_collision_polygon():
	# Points
	var points := PackedVector2Array()
	points.append(Vector2(left, up))
	points.append(Vector2(right, up))
	points.append(Vector2(0, down))
	collision_polygon.polygon = points
