class_name BossShooterStateMachine extends StateMachine

# Export variables
@export var special_state: State # state that will always run

# Game functions
func _ready():
	special_state.enter_state()
	
func _process(delta):
	special_state.update(delta)
	super._process(delta)
	
func _physics_process(delta):
	special_state.physics_update(delta)
	super._physics_process(delta)
