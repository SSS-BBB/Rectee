@tool
class_name ShooterPathMoveState extends State

# Export variables
@export var shooter: Shooter
@export var shooter_path: ShooterPathMove
@export var shooting_component: ShooterShooting

# Game functions
func _process(_delta):
	if Engine.is_editor_hint():
		set_path_property()

# Override functions
func enter_state():
	set_path_property()
	shooter_path.move()

func update(_delta):
	shooting_component.shoot()

func exit_state():
	shooter_path.stop_move()
	
# Class functions
func set_path_property():
	if shooter and shooter.path_curve:
		shooter_path.curve = shooter.path_curve
		shooter_path.path_duration = shooter.path_duration
		shooter_path.loop = shooter.path_loop
	else:
		shooter_path.curve = null
	
	
	
