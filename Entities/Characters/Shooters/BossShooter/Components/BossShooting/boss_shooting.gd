class_name BossShooting extends Shooting

# Export variables
@export_group("Bullet Properties")
@export var boss_bullet_fire_rate: float = 1.0
@export var boss_bullet_damage: int = 2
@export var boss_bullet_speed: float = 300.0
@export var boss_bullet_scale: Vector2 = 1.5 * Vector2.ONE

# Shooting functions
func init_variables():
	fire_rate = boss_bullet_fire_rate
	damage = boss_bullet_damage
	bullet_speed = boss_bullet_speed
	bullet_scale = boss_bullet_scale
