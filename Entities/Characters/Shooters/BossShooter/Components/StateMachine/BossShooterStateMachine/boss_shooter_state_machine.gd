class_name BossShooterStateMachine extends MultipleStatesMachine

# Export variables
@export_range(0.1, 100.0, 0.1) var random_state_interval: float = 5.0
@export var activate_shooting_state: bool = true
@export var activate_spawning_state: bool = true

# Component variables
@onready var wandering_state: WanderingState = $WanderingState as WanderingState
@onready var lookat_player_state: LookatPlayerState = $LookatPlayerState as LookatPlayerState
@onready var boss_shooting_state: BossShootingState = $BossShootingState as BossShootingState
@onready var boss_spawning_state: BossSpawningState = $BossSpawningState as BossSpawningState

@onready var random_state_timer: Timer = $RandomStateTimer as Timer

# Class variables
var player: Player
var attack_states: Array[State]

# Game functions
func _ready() -> void:
	super._ready()
	
	# wandering state
	insert_state(0, wandering_state)
	
	# look at player state
	player = get_tree().get_first_node_in_group("player")
	lookat_player_state.init_player(player)
	insert_state(1, lookat_player_state)
	
	# attacking states
	if activate_shooting_state:
		attack_states.append(boss_shooting_state)
	if activate_spawning_state:
		attack_states.append(boss_spawning_state)
	
	random_state_timer.wait_time = random_state_interval
	random_attacking_state()

# Class functions
func random_attacking_state() -> void:
	insert_state(2, attack_states.pick_random())
	random_state_timer.start()

# Signal functions
func _on_random_state_timer_timeout() -> void:
	random_attacking_state()
