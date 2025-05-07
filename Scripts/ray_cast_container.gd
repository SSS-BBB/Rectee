@tool
class_name RayCastContainer extends Node2D

# Export variables
@export var auto_ray_add: bool = true:
	set(value):
		auto_ray_add = value
		notify_property_list_changed()
@export_category("Ray Properties")
@export var ray_size: float = 50.0

# Game functions
func _validate_property(property: Dictionary):
	if property.name == "ray_size" and not auto_ray_add:
		property.usage |= PROPERTY_USAGE_READ_ONLY

func _ready():
	if not Engine.is_editor_hint() and auto_ray_add:
		add_multiple_rays()
	
func _process(_delta):
	if Engine.is_editor_hint() and auto_ray_add:
		add_multiple_rays()
	
# Class functions
func add_multiple_rays():
	if Engine.is_editor_hint():
		remove_all_rays()
	
	add_ray(0)
	
	# look down rays
	add_ray(PI/12)
	add_ray(PI/6)
	add_ray(PI/4)
	add_ray(PI/3)
	
	# look up rays
	add_ray(-PI/12)
	add_ray(-PI/6)
	add_ray(-PI/4)
	add_ray(-PI/3)

func add_ray(angle: float):
	var ray := RayCast2D.new()
	ray.target_position.x = -ray_size * cos(angle)
	ray.target_position.y = ray_size * sin(angle)
	add_child(ray)
	
func remove_all_rays():
	for child in get_children():
		if child is RayCast2D:
			remove_child(child)
	
	
	
