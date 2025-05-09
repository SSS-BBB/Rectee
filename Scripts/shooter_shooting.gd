class_name ShooterShooting extends Shooting

# Export variables
@export var shooter_body: ShooterBody

# Class variables
var shooter: Shooter

# Override functions
func init_variables():
	shooter = shooter_body.shooter_container
	fire_rate = shooter.fire_rate
	damage = shooter.shooting_damage
	bullet_speed = shooter.bullet_speed
	bullet_scale = 1.25*Vector2.ONE
	
func shoot(shoot_direction: Vector2 = Vector2.ZERO):
	if shoot_direction == Vector2.ZERO:
		# default direction
		super.shoot(shooter_body.global_position.direction_to(global_position))
	else:
		# custom direction
		super.shoot(shoot_direction)
