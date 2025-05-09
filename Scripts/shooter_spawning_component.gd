class_name ShooterSpawningComponent extends SpawningComponent

# Export variables
@export var parent_node: Node2D # for scaling

@export_category("Shooter Properties Range")
@export var bullet_damage_range: Vector2i = Vector2i(1, 3)
@export var fire_rate_range: Vector2 = Vector2(0.8, 1.9)
@export var bullet_speed_range: Vector2 = Vector2(250.0, 500.0)
@export var shooter_speed_range: Vector2 = Vector2(10.0, 40.0)
@export var shooter_health_range: Vector2i = Vector2(2, 5)
@export var shooter_ignore_raycast: bool = true

# Spawning Component functions
func create_spawn() -> Node2D:
	# random shooter properties
	var rand_bullet_damage := randi_range(bullet_damage_range.x, bullet_damage_range.y)
	var rand_fire_rate := randf_range(fire_rate_range.x, fire_rate_range.y)
	var rand_bullet_speed := randf_range(bullet_speed_range.x, bullet_speed_range.y)
	var rand_shooter_speed := randf_range(shooter_speed_range.x, shooter_speed_range.y)
	var rand_health := randi_range(shooter_health_range.x, shooter_health_range.y)
	
	# create shooter
	var spawn_shooter := Shooter.new_follow_shooter(rand_bullet_damage, rand_fire_rate, rand_bullet_speed, rand_shooter_speed, shooter_ignore_raycast, rand_health)
	var random_offset := Vector2(randf_range(-20, 20), randf_range(20, 20))
	spawn_shooter.global_position = global_position + random_offset
	
	if parent_node:
		spawn_shooter.scale = parent_node.scale
	
	return spawn_shooter
