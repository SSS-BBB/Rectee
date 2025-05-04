@tool
class_name Spike extends StaticBody2D

# Export variables
@export var resource: SpikeResource

# Component variables
@onready var sprite = $Sprite2D as Sprite2D
@onready var collision_polygon = $CollisionPolygon2D as CollisionPolygon2D
@onready var collision_area_1 = $Area2D/CollisionArea1 as CollisionShape2D
@onready var collision_area_2 = $Area2D/CollisionArea2 as CollisionShape2D

# Game functions
func _ready():
	if not Engine.is_editor_hint():
		set_sprite()
		set_collision_polygon()
		set_area_collision()
	
func _process(_delta):
	if Engine.is_editor_hint():
		set_sprite()
		set_collision_polygon()
		set_area_collision()
		
# Class functions
func set_collision_polygon():	
	var sprite_width = resource.texture_region.size.x
	var sprite_height = resource.texture_region.size.y
	# Points
	var left = -sprite_width/2.0 + 1.0
	var right = sprite_width/2.0 - 1.0
	var up = -sprite_height/2.0 + 1.0
	var down = sprite_height/2.0 - 1.0
	
	var points := PackedVector2Array()
	points.append(Vector2(left, down))
	points.append(Vector2(right, down))
	points.append(Vector2(0, up))
	collision_polygon.polygon = points
	
func set_sprite():
	if resource:
		sprite.texture = resource.texture
		sprite.region_rect = resource.texture_region
		
func set_area_collision():
	var sprite_width = sprite.region_rect.size.x
	var sprite_height = sprite.region_rect.size.y
	
	# print("(" + str(sprite_width) + ", " + str(sprite_height) + ")")
	
	# 1 (left)
	var rect_shape_1 := RectangleShape2D.new()
	
	# set size
	var a = (sprite_width*sprite_width) / 2.0
	var b = sprite_height*sprite_height
	var line_length := sqrt(a + b) - 0.5
	rect_shape_1.size = Vector2(1, line_length)
	collision_area_1.shape = rect_shape_1
	
	# set angle
	# var tan = (2.0*sprite_height) / sprite_width
	var theta = atan2(sprite_height / 2.0, sprite_width / 4.0)
	collision_area_1.rotation = PI/2 - theta
	
	# set position
	var offset_1 := 0.6*Vector2.LEFT + Vector2.UP
	collision_area_1.position = Vector2(-sprite_width / 4.0, 0.0) + offset_1
	
	# 2 (right)
	var rect_shape_2 := RectangleShape2D.new()
	
	# set size
	rect_shape_2.size = Vector2(1, line_length)
	collision_area_2.shape = rect_shape_2
	
	# set angle
	# var tan = (2.0*sprite_height) / sprite_width
	var theta_2 = atan2(sprite_height / 2.0, sprite_width / 4.0)
	collision_area_2.rotation = -(PI/2 - theta_2)
	
	# set position
	var offset_2 :=  0.6*Vector2.RIGHT + Vector2.UP
	collision_area_2.position = Vector2(sprite_width / 4.0, 0.0) + offset_2


func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("player"):
		var player := body as Player
		var damage := resource.damage
		var jump_knockback := 400 + damage * 50 # TODO: knockback in resource
		player.take_spike_damage(resource.damage, jump_knockback)
