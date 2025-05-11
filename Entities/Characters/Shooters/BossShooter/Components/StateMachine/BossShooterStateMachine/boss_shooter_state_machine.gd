class_name BossShooterStateMachine extends MultipleStatesMachine

# Export variables
@export_range(0.1, 100.0, 0.1) var random_state_interval: float = 5.0

# Component variables
@onready var wandering_state = $WanderingState as WanderingState
@onready var lookat_player_state = $LookatPlayerState as LookatPlayerState
@onready var boss_shooting_state = $BossShootingState as BossShootingState
@onready var boss_spawning_state = $BossSpawningState as BossSpawningState

@onready var random_state_timer = $RandomStateTimer as Timer

# Class variables
var player: Player

# Game functions
func _ready():
	super._ready()
	
	# wandering state
	insert_state(0, wandering_state)
	
	# look at player state
	player = get_tree().get_first_node_in_group("player")
	lookat_player_state.init_player(player)
	insert_state(1, lookat_player_state)
	
	# attacking states
	random_state_timer.wait_time = random_state_interval
	random_attacking_state()

# Class functions
func random_attacking_state():
	var attack_states := [boss_shooting_state, boss_spawning_state]
	insert_state(2, attack_states.pick_random())
	random_state_timer.start()

# Signal functions
func _on_random_state_timer_timeout():
	random_attacking_state()
