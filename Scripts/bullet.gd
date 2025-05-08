class_name Bullet extends Area2D

# Component variables
@onready var bullet_movement = $BulletMovement as BulletMovement
@onready var bullet_hit = $BulletHit as BulletHit

# Export variables
@export_group("Bullet Movement")
@export var bullet_speed: float = 500.0
@export var bullet_direction: Vector2 = Vector2.LEFT:
	set(direction):
		bullet_direction = direction
		bullet_direction = bullet_direction.normalized()
		rotation = atan2(-bullet_direction.y, -bullet_direction.x)

@export_group("Bullet Hit")
@export var bullet_damage: int = 1
	
