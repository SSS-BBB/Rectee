@tool
class_name Shooter extends Node2D

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

# Component variables
@onready var ray_cast_container = $ShooterPathMove/ShooterBody/RayCastContainer as RayCastContainer
@onready var shoot_position = $ShooterPathMove/ShooterBody/ShooterShooting/ShootPosition as Node2D
@onready var sprite = $ShooterPathMove/ShooterBody/Sprite2D as Sprite2D

@onready var shooter_state_machine = $ShooterStateMachine as ShooterStateMachine
@onready var shooter_idle_state = $ShooterStateMachine/ShooterIdleState as State
@onready var shooter_path_move_state = $ShooterStateMachine/ShooterPathMoveState as State
@onready var shooter_follow_state = $ShooterStateMachine/ShooterFollowState as State


# Signals
signal state_change

# Game functions
func _validate_property(property: Dictionary):
	if (property.name == "path_curve" or property.name == "path_duration" or property.name == "path_loop") and selected_state != ShooterState.PATH_MOVE:
		property.usage |= PROPERTY_USAGE_READ_ONLY
		
	if (property.name == "follow_speed" or property.name == "follow_distance") and selected_state != ShooterState.FOLLOW_MOVE:
		property.usage |= PROPERTY_USAGE_READ_ONLY

func _ready():
	if Engine.is_editor_hint():
		return
	
	if flip_h:
		sprite.flip_h = !sprite.flip_h
		ray_cast_container.flip_h_ray()
		shoot_position.position.x *= -1
	
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
			
# Signal functions
func _on_state_changed(new_state_select: ShooterState):
	match new_state_select:
		ShooterState.IDLE:
			shooter_state_machine.change_state(shooter_idle_state)
		ShooterState.PATH_MOVE:
			shooter_state_machine.change_state(shooter_path_move_state)
		ShooterState.FOLLOW_MOVE:
			shooter_state_machine.change_state(shooter_follow_state)
		_:
			shooter_state_machine.change_state(shooter_idle_state)
