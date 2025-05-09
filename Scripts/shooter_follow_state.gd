class_name ShooterFollowState extends State

# Export variables
@export var shooter_body: ShooterBody
@export var shooting_component: ShooterShooting

# Class variables
var move_speed: float
var follow_distance: float
var player_to_follow: Player

# State functions
func enter_state():
	player_to_follow = get_tree().get_first_node_in_group("player")
	move_speed = shooter_body.shooter_container.follow_speed
	follow_distance = shooter_body.shooter_container.follow_distance
	shooter_body.see_player.connect(_follow_player)

func physics_update(delta):
	if shooter_body.shooter_container.ignore_raycast:
		_follow_player(player_to_follow, delta)

func exit_state():
	shooter_body.see_player.disconnect(_follow_player)

# Signal functions
func _follow_player(player: Player, delta: float):
	# shoot
	shooting_component.shoot(shooter_body.global_position.direction_to(player.global_position))
	
	if shooter_body.global_position.distance_to(player.global_position) < follow_distance:
		return
	# move
	shooter_body.global_position = shooter_body.global_position.move_toward(player.global_position, move_speed * delta)
	shooter_body.move_and_slide()
	
	# turn to player
	shooter_body.look_at(player.global_position)
	if not shooter_body.shooter_container.flip_h:
		shooter_body.rotate(PI)
	
	# check flip v
	var degree_mod = abs(fmod(shooter_body.rotation, 2*PI))
	# check quadrant
	if degree_mod > PI/2 and degree_mod < (3*PI) / 2:
		shooter_body.shooter_container.flip_sprite(false, true, true)
	else:
		shooter_body.shooter_container.flip_sprite(false, true, false)
	
	
