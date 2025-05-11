class_name LookatPlayerState extends State

# Export variables
@export var actor_sprite: Sprite2D

# Class variables
var player: Player

# State functions
func update(_delta):
	if player and actor_sprite:
		actor_sprite.look_at(player.global_position)
		actor_sprite.rotate(PI)
		
		# check flip v
		var degree_mod = abs(fmod(actor_sprite.rotation, 2*PI))
		# check quadrant
		if degree_mod > PI/2 and degree_mod < (3*PI) / 2:
			actor_sprite.flip_v = true
		else:
			actor_sprite.flip_v = false
		
# Class functions
func init_player(p: Player):
	player = p
