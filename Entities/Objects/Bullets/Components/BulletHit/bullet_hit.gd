class_name BulletHit extends Node2D

# Export variables
@export var bullet: Bullet

# Game functions
func _ready():
	if bullet:
		bullet.body_entered.connect(_on_bullet_hit)

# Signal functions
func _on_bullet_hit(body: Node2D):
	# bullet goes through shooters
	if body.is_in_group("shooter_body"):
		return
	
	if body.is_in_group("player"):
		var player := body as Player
		var bullet_velocity := bullet.bullet_direction * bullet.bullet_speed
		var knockback_force := (player.velocity - bullet_velocity).length()
		player.take_bullet_damage(bullet.bullet_damage, bullet.global_position, knockback_force)
	
	bullet.call_deferred("queue_free")
