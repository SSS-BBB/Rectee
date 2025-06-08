class_name BossSpawningState extends State

# Export variables
@export var spawning_component: SpawningComponent

# State functions
func physics_update(_delta: float) -> void:
	if spawning_component:
		spawning_component.spawn()
