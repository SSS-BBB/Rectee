class_name Bullet extends Area2D

const BULLET_SCENE: PackedScene = preload("res://Scenes/Objects/bullet.tscn")

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


static func new_bullet(damage: int, speed: float, pos: Vector2, direction: Vector2, b_scale: Vector2) -> Bullet:
	var bullet := BULLET_SCENE.instantiate() as Bullet
	bullet.bullet_damage = damage
	bullet.bullet_speed = speed
	bullet.global_position = pos
	bullet.bullet_direction = direction
	bullet.scale = b_scale
	return bullet
