class_name DestroyOnDie extends Node2D

# Export variables
@export var parent_node: Node2D
@export var health_component: HealthComponent

# Game functions
func _ready():
	health_component.actor_die.connect(_on_actor_die)

# Signal functions
func _on_actor_die():
	parent_node.call_deferred("queue_free")
