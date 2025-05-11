class_name BossShootingState extends State

# Export variables
@export var boss_body: PhysicsBody2D
@export var boss_shooting_component: BossShooting

# State functions
func physics_update(_delta):
	var bullet_direction := boss_body.global_position.direction_to(boss_shooting_component.global_position)
	boss_shooting_component.shoot(bullet_direction)
