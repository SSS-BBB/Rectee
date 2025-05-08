class_name WanderingState extends State

# Export variables
@export var actor: CharacterBody2D
@export_range(0.0, 100.0, 0.1) var min_distant_to_target: float = 20.0
@export var wandering_speed: float = 150.0

# Component variables
@onready var wandering_area = $WanderingArea as Area2D
@onready var collision_shape = $WanderingArea/CollisionShape2D as CollisionShape2D
@onready var point_debug = $PointDebug as Sprite2D

# Class variables
var current_target: Vector2
var distant_to_target: float

# Override functions
func enter_state():
	distant_to_target = min_distant_to_target * max(actor.scale.x, actor.scale.y)
	random_target_point()
	
func physics_update(delta):
	if actor.global_position.distance_to(current_target) <= distant_to_target:
		random_target_point()
	
	actor.global_position = actor.global_position.move_toward(current_target, wandering_speed*delta)
	actor.move_and_slide()
	
# Class functions
func random_target_point():
	var left: float = wandering_area.global_position.x - (collision_shape.shape.get_rect().size.x/2.0)
	var right: float = wandering_area.global_position.x + (collision_shape.shape.get_rect().size.x/2.0)
	var top: float = wandering_area.global_position.y - (collision_shape.shape.get_rect().size.y/2.0)
	var bottom: float = wandering_area.global_position.y + (collision_shape.shape.get_rect().size.y/2.0)
	current_target = Vector2(randf_range(left, right), randf_range(top, bottom))
	while actor.global_position.distance_to(current_target) <= distant_to_target:
		current_target = Vector2(randf_range(left, right), randf_range(top, bottom))
	
	point_debug.global_position = current_target
