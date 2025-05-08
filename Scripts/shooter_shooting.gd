class_name ShooterShooting extends Node2D

# Export variables
@export var shooter_body: ShooterBody

# Component variables
@onready var timer = $Timer as Timer
@onready var shoot_position = $ShootPosition as Node2D

# Class variables
var shooter: Shooter
var can_shoot: bool
var bullet_resource := preload("res://Scenes/Objects/bullet.tscn")

# Game functions
func _ready():
	shooter = shooter_body.shooter_container
	timer.wait_time = shooter.fire_rate
	can_shoot = true

# Class functions
func shoot(shoot_direction: Vector2 = Vector2.ZERO):
	if not can_shoot:
		return
		
	# shoot
	var bullet := bullet_resource.instantiate() as Bullet
	bullet.bullet_damage = shooter.shooting_damage
	bullet.bullet_speed = shooter.bullet_speed
	bullet.global_position = shoot_position.global_position
	if shoot_direction == Vector2.ZERO:
		# default direction
		bullet.bullet_direction = shoot_position.global_position - global_position
	else:
		# custom direction
		bullet.bullet_direction = shoot_direction
	bullet.scale = shooter.scale - 1.5*Vector2.ONE
	
	var bullet_container_node := get_tree().get_first_node_in_group("bullet_container")
	if not bullet_container_node:
		return
	bullet_container_node.add_child(bullet)
	can_shoot = false
	if timer.is_stopped():
		timer.start()

# Signal functions
func _on_timer_timeout():
	# fire rate timer
	can_shoot = true
