class_name Shooting extends Node2D

# Export variables
@export var bullet_resource: Resource

# Component variables
@onready var timer = $Timer as Timer

# Class variables
var fire_rate: float
var damage: int
var bullet_speed: float
var can_shoot: bool
var bullet_scale: Vector2

# Game functions
func _ready():
	init_variables()
	if fire_rate:
		timer.wait_time = fire_rate
	can_shoot = true

# Class functions
func init_variables():
	pass
	
func shoot(shoot_direction: Vector2 = Vector2.ZERO):
	if not can_shoot:
		return
	
	# init bullet
	var bullet := bullet_resource.instantiate() as Bullet
	bullet.bullet_damage = damage
	bullet.bullet_speed = bullet_speed
	bullet.global_position = global_position
	bullet.bullet_direction = shoot_direction
	bullet.scale = bullet_scale
	
	# add bullet to container
	var bullet_container_node := get_tree().get_first_node_in_group("bullet_container")
	if not bullet_container_node:
		return
	bullet_container_node.add_child(bullet)
	
	# fire rate logic
	can_shoot = false
	if timer.is_stopped():
		timer.start()

# Signal functions
func _on_timer_timeout():
	can_shoot = true
