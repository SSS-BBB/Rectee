class_name ShooterFollowState extends State

# Export variables
@export var shooter_body: ShooterBody
@export var shooting_component: ShooterShooting

# Class variables
var move_speed: float
var follow_distance: float

# Override functions
func enter_state():
	move_speed = shooter_body.shooter_container.follow_speed
	follow_distance = shooter_body.shooter_container.follow_distance
	shooter_body.see_player.connect(_follow_player)
	
func exit_state():
	shooter_body.see_player.disconnect(_follow_player)

# Signal functions
func _follow_player(player: Player, delta: float):
	if shooter_body.global_position.distance_to(player.global_position) < follow_distance:
		return
	# move
	shooter_body.global_position = shooter_body.global_position.move_toward(player.global_position, move_speed * delta)
	
	# shoot
	shooting_component.shoot(shooter_body.global_position.direction_to(player.global_position))
	
	
