### this component will tell which side target group has entered to

class_name AreaEnterComponent extends Area2D

# Export variables
@export var target_group: String = "player"

# Component variables
@onready var collision_shape = $CollisionShape2D as CollisionShape2D

# Signals
signal target_enter_area(enter_to)

# statics
enum EnterTo { NULL, LEFT, RIGHT, TOP, BOTTOM }
static func get_opposite(direction: EnterTo) -> EnterTo:
	# check horizontal
	if direction == EnterTo.LEFT:
		return EnterTo.RIGHT
	if direction == EnterTo.RIGHT:
		return EnterTo.LEFT
	if direction == EnterTo.TOP:
		return EnterTo.BOTTOM
	if direction == EnterTo.BOTTOM:
		return EnterTo.TOP
	
	return EnterTo.NULL


# Signal functions
func _on_body_exited(body: Node2D):
	if not body.is_in_group(target_group):
		return
	
	# check x
	if body.global_position.x <= collision_shape.global_position.x:
		target_enter_area.emit(EnterTo.LEFT)
	else:
		target_enter_area.emit(EnterTo.RIGHT)
	# check y
	if body.global_position.y <= collision_shape.global_position.y:
		target_enter_area.emit(EnterTo.TOP)
	else:
		target_enter_area.emit(EnterTo.BOTTOM)
	
