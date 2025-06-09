class_name DropOnDieComponent extends Node2D

# Export variables
@export_group("Actor Properties")
@export var health_component: HealthComponent
@export var actor_body: PhysicsBody2D
@export_group("Drop Object Properties")
@export var to_drop: PackedScene
@export var drop_to_group: String
@export var drop_on_body: bool = true
@export var drop_position: Vector2
@export var drop_scale: Vector2 = Vector2.ONE

# Game functions
func _ready() -> void:
	if not health_component or not to_drop or drop_to_group.is_empty() or not actor_body:
		push_error("Initialize or Export variables.")
		return
	
	health_component.actor_die.connect(drop)


# Class functions
func drop() -> void:
	var drop_object: Node2D = to_drop.instantiate()
	if drop_on_body:
		drop_object.global_position = actor_body.global_position
	else:
		drop_object.global_position = drop_position
	drop_object.scale = drop_scale
	
	var container: Node2D = get_tree().get_first_node_in_group(drop_to_group)
	container.call_deferred("add_child", drop_object)
