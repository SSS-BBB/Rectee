@tool
class_name Spike extends PhysicsBody2D

# Export variables
@export var resource: SpikeResource

# Component variables
@onready var sprite = $Sprite2D as Sprite2D
@onready var collision_polygon = $CollisionPolygon2D as CollisionPolygon2D

# Class variables
var sprite_width
var sprite_height
var left
var right
var up
var down

# Game functions
func _ready():
	if not Engine.is_editor_hint():
		set_variables()
		set_sprite()
		set_collision_polygon()
	
func _process(_delta):
	if Engine.is_editor_hint():
		set_variables()
		set_sprite()
		set_collision_polygon()

# Class functions
func set_variables():
	if resource:
		sprite_width = resource.texture_region.size.x
		sprite_height = resource.texture_region.size.y
		
		left = -sprite_width/2.0 + 1.0
		right = sprite_width/2.0 - 1.0
		up = -sprite_height/2.0 + 1.0
		down = sprite_height/2.0 - 1.0

func set_collision_polygon():
	if collision_polygon:
		# Points
		var points := PackedVector2Array()
		points.append(Vector2(left, down))
		points.append(Vector2(right, down))
		points.append(Vector2(0, up))
		collision_polygon.polygon = points
	
func set_sprite():
	if resource:
		sprite.texture = resource.texture
		sprite.region_rect = resource.texture_region
