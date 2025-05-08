class_name ShooterIdleState extends State

# Export variables
@export var shooting_component: ShooterShooting

# Override functions
func update(_delta):
	shooting_component.shoot()
