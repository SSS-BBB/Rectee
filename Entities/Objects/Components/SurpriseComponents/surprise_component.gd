@tool
class_name SurpriseComponent extends Node2D

# Export variables
@export var node: Node2D
@export_group("Area adjustment")
@export var adjust_area: bool = false
@export var area_offset: Vector2 = 5 * Vector2.UP

# Component variables
@onready var show_area = $ShowArea as Area2D
@onready var collision_shape = $ShowArea/CollisionShape2D as CollisionShape2D

# Class variables
var node_sprite: Sprite2D
var width: float
var height: float

# Game functions
func _ready():
	if not node:
		return
	
	if not Engine.is_editor_hint() and not adjust_area:
		set_variables()
		set_show_position()
		# set_show_size()
		
	node.visible = false
		
func _process(_delta):
	if Engine.is_editor_hint() and not adjust_area:
		set_variables()
		set_show_position()
		# set_show_size()

func _get_configuration_warnings():
	var warnings: Array[String] = []
	if not node:
		warnings.append("Please enter node you'd like to use with this component.")
	return warnings

# Class functions
func set_variables():
	if not node:
		return
	
	for child in node.get_children():
		if child is Sprite2D:
			node_sprite = child as Sprite2D
			break
			
	width = node_sprite.region_rect.size.x
	height = node_sprite.region_rect.size.y

func set_show_position():
	show_area.position.y = -height
	show_area.position.x = 0
	show_area.position += area_offset
	
func set_show_size():
	# set collision of show area size
	var rect_shape = RectangleShape2D.new()
	rect_shape.size = Vector2(width, height)
	collision_shape.shape = rect_shape
		
		
# Signal functions
func _on_show_area_body_entered(body: Node2D):
	if body.is_in_group("player"):
		node.visible = true

func _on_show_area_body_exited(body):
	if body.is_in_group("player"):
		node.visible = false
