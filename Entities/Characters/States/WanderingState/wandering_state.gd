class_name WanderingState extends State

# Export variables
@export var actor: PhysicsBody2D
@export_range(0.0, 100.0, 0.1) var min_distant_to_target: float = 50.0
@export_range(0.0, 100.0, 0.1) var min_change_distance: float = 90.0 # minimum distance for changing target
@export var wandering_speed: float = 150.0
@export var point_debug: Sprite2D

# Component variables
@onready var collision_shape = $WanderingArea/CollisionShape2D as CollisionShape2D

# Class variables
var current_target: Vector2
var distant_to_target: float

# Game functions
func _ready():
	# make sure change distance is reasonable
	min_change_distance = min(min_change_distance, min(collision_shape.shape.get_rect().size.x / 2.0, collision_shape.shape.get_rect().size.y / 2.0))

# Override functions
func enter_state():
	distant_to_target = min_distant_to_target * max(actor.scale.x, actor.scale.y)
	random_target_point()
	
func physics_update(delta):
	if actor.global_position.distance_to(current_target) <= distant_to_target:
		random_target_point()
	
	actor.global_position = actor.global_position.move_toward(current_target, wandering_speed*delta)
	
# Class functions
func random_target_point():
	var left: float = collision_shape.global_position.x - (collision_shape.shape.get_rect().size.x/2.0)
	var right: float = collision_shape.global_position.x + (collision_shape.shape.get_rect().size.x/2.0)
	var top: float = collision_shape.global_position.y - (collision_shape.shape.get_rect().size.y/2.0)
	var bottom: float = collision_shape.global_position.y + (collision_shape.shape.get_rect().size.y/2.0)
	current_target = Vector2(randf_range(left, right), randf_range(top, bottom))
	while actor.global_position.distance_to(current_target) <= min_change_distance:
		current_target = Vector2(randf_range(left, right), randf_range(top, bottom))
	
	if point_debug:
		point_debug.global_position = current_target
