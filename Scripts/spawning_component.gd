class_name SpawningComponent extends Node2D

# Export variables
@export var spawn_scene: PackedScene
@export var spawn_container_group: String
@export var spawning_rate: float = 1.5
@export var spawning_limit: int = 0

# Component variables
@onready var timer = $Timer as Timer

# Class variables
var can_spawn: bool

# Game functions
func _ready():
	timer.wait_time = spawning_rate
	can_spawn = true

# Class functions
func spawn():
	if not can_spawn:
		return
	
	# spawn
	var spawn_node := create_spawn()
	var spawn_container := get_tree().get_first_node_in_group(spawn_container_group)
	if not spawn_container:
		push_error("Cannot find node group: " + spawn_container_group)
	if spawn_container.get_child_count() > spawning_limit and spawning_limit != 0:
		return
	spawn_container.add_child(spawn_node)
	
	# set timing
	can_spawn = false
	if timer.is_stopped():
		timer.start()

func create_spawn() -> Node2D:
	# inherit this function to set spawn property
	return spawn_scene.instantiate()


# Signal functions
func _on_timer_timeout():
	can_spawn = true
