class_name BulletMovement extends Node2D

# Export variables
@export var bullet: Bullet

# Game functions
func _physics_process(delta):
	if bullet:
		bullet.position += bullet.bullet_direction * bullet.bullet_speed * delta
