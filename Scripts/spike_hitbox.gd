@tool
class_name SpikeHitbox extends Node2D

# Export variables
@export var spike: Spike

# Component variable
@onready var hit_area = $Area2D
@onready var collision_area_1 = $Area2D/CollisionArea1
@onready var collision_area_2 = $Area2D/CollisionArea2

# Class variables
var sprite_width
var sprite_height

# Game functions
func _ready():
	if not Engine.is_editor_hint() and spike:
		set_variables()
		set_area_collision()
	
func _process(_delta):
	if Engine.is_editor_hint() and spike:
		set_variables()
		set_area_collision()

# Class functions
func set_variables():
	sprite_width = spike.resource.texture_region.size.x
	sprite_height = spike.resource.texture_region.size.y

func set_area_collision():
	# get variables
	var collision_size := get_collision_size()
	var theta = get_collision_angle()
	var collision_position := get_collision_position()
	
	# 1 (left)
	var rect_shape_1 := RectangleShape2D.new()
	rect_shape_1.size = collision_size
	collision_area_1.shape = rect_shape_1
	
	collision_area_1.rotation = theta
	
	var offset_1 := 0.6*Vector2.LEFT + Vector2.UP
	collision_area_1.position = collision_position + offset_1
	
	# 2 (right)
	var rect_shape_2 := RectangleShape2D.new()
	rect_shape_2.size = collision_size
	collision_area_2.shape = rect_shape_2
	
	collision_area_2.rotation = -theta
	
	var offset_2 :=  0.6*Vector2.RIGHT + Vector2.UP
	collision_area_2.position = -collision_position + offset_2

func get_collision_size() -> Vector2:
	var a = (sprite_width*sprite_width) / 2.0
	var b = sprite_height*sprite_height
	var line_length := sqrt(a + b) - 0.5
	return Vector2(1, line_length)
	
func get_collision_angle() -> float:
	return PI/2 - atan2(sprite_height / 2.0, sprite_width / 4.0)
	
func get_collision_position() -> Vector2:
	return Vector2(-sprite_width / 4.0, 0.0)
