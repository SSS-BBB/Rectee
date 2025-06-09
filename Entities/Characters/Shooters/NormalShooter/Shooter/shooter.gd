@tool
class_name Shooter extends Node2D

const SHOOTER_INSTANCE: PackedScene = preload("res://Entities/Characters/Shooters/NormalShooter/Shooter/shooter.tscn")

# Export variables
enum ShooterState { IDLE, PATH_MOVE, FOLLOW_MOVE }
@export var flip_h: bool = false
@export var selected_state: ShooterState = ShooterState.IDLE:
	set(state):
		selected_state = state
		
		if not Engine.is_editor_hint():
			state_change.emit(state)
		else:
			notify_property_list_changed()

@export_category("Shooter Properties")
@export var shooter_max_health: int = 3
@export var died_on_timeout: bool = false
@export var alive_time: float = 5.0

@export_category("Shooting Properties")
@export var shooting_damage: int = 1
@export var fire_rate: float = 1.5
@export var bullet_speed: float = 300.0

@export_category("Movement Properties")
@export_group("Path Movement")
@export var path_curve: Curve2D
@export var path_duration: float = 1.0
@export var path_loop: bool = false

@export_group("Follow Movement")
@export var follow_speed: float = 50.0
@export var follow_distance: float = 50.0
@export var ignore_raycast: bool = false # if true shooter will follow player even when they don't see player

# Component variables
@onready var ray_cast_container: RayCastContainer = $ShooterPathMove/ShooterBody/RayCastContainer as RayCastContainer
@onready var sprite: Sprite2D = $ShooterPathMove/ShooterBody/Sprite2D as Sprite2D as Sprite2D
@onready var shooter_shooting: ShooterShooting = $ShooterPathMove/ShooterBody/ShooterShooting as ShooterShooting

@onready var shooter_state_machine: ShooterStateMachine = $ShooterStateMachine as ShooterStateMachine
@onready var shooter_idle_state: State = $ShooterStateMachine/ShooterIdleState as State
@onready var shooter_path_move_state: State = $ShooterStateMachine/ShooterPathMoveState as State
@onready var shooter_follow_state: State = $ShooterStateMachine/ShooterFollowState as State

@onready var health_component: HealthComponent = $HealthComponent as HealthComponent
@onready var died_on_timeout_component: DiedOnTimeoutComponent = $DiedOnTimeoutComponent

# Signals
signal state_change

# Constructor
static func new_follow_shooter(damage: int, rate: float, shoot_speed: float, speed: float, shooter_alive_time: float, shooter_igore_raycast: bool = false, hp: int = 3, dist: float = 50.0, shooter_died_on_timeout: bool = true) -> Shooter:
	var new_shooter := SHOOTER_INSTANCE.instantiate() as Shooter
	
	# shooter properties
	new_shooter.shooter_max_health = hp
	new_shooter.died_on_timeout = shooter_died_on_timeout
	new_shooter.alive_time = shooter_alive_time
	
	# shooting properties
	new_shooter.shooting_damage = damage
	new_shooter.fire_rate = rate
	new_shooter.bullet_speed = shoot_speed
	
	# following properties
	new_shooter.selected_state = ShooterState.FOLLOW_MOVE
	new_shooter.follow_speed = speed
	new_shooter.ignore_raycast = shooter_igore_raycast
	new_shooter.follow_distance = dist
	
	return new_shooter

# Game functions
func _validate_property(property: Dictionary) -> void:
	if (property.name == "path_curve" or property.name == "path_duration" or property.name == "path_loop") and selected_state != ShooterState.PATH_MOVE:
		property.usage |= PROPERTY_USAGE_READ_ONLY
		
	if (property.name == "follow_speed" or property.name == "follow_distance") and selected_state != ShooterState.FOLLOW_MOVE:
		property.usage |= PROPERTY_USAGE_READ_ONLY

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	# shooter properties
	if flip_h:
		flip()
	health_component.update_max_health(shooter_max_health)
	
	# state connect
	state_change.connect(_on_state_changed)
	
	match selected_state:
		ShooterState.IDLE:
			state_change.emit(ShooterState.IDLE)
		ShooterState.PATH_MOVE:
			state_change.emit(ShooterState.PATH_MOVE)
		ShooterState.FOLLOW_MOVE:
			state_change.emit(ShooterState.FOLLOW_MOVE)
		_:
			state_change.emit(ShooterState.IDLE)
	
	if died_on_timeout:
		died_on_timeout_component.dead_time = alive_time
		died_on_timeout_component.start_countdown()

# Class functions
func flip() -> void:
	sprite.flip_h = !sprite.flip_h
	ray_cast_container.flip_h_ray()
	shooter_shooting.position.x *= -1
	
func flip_sprite(h: bool, v: bool, value: bool) -> void:
	if h:
		sprite.flip_h = value
	if v:
		sprite.flip_v = value

# Signal functions
func _on_state_changed(new_state_select: ShooterState) -> void:
	match new_state_select:
		ShooterState.IDLE:
			shooter_state_machine.change_state(shooter_idle_state)
		ShooterState.PATH_MOVE:
			shooter_state_machine.change_state(shooter_path_move_state)
		ShooterState.FOLLOW_MOVE:
			shooter_state_machine.change_state(shooter_follow_state)
		_:
			shooter_state_machine.change_state(shooter_idle_state)
