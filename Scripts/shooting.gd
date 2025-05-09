class_name Shooting extends Node2D

# Component variables
@onready var timer = $Timer as Timer
@onready var shooting_audio = $ShootingAudio as AudioStreamPlayer2D


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
	var bullet := Bullet.new_bullet(damage, bullet_speed, global_position, shoot_direction, bullet_scale)
	
	# add bullet to container
	var bullet_container_node := get_tree().get_first_node_in_group("bullet_container")
	if not bullet_container_node:
		return
	bullet_container_node.add_child(bullet)
	
	# play shooting audio
	shooting_audio.play()
	
	# fire rate logic
	can_shoot = false
	if timer.is_stopped():
		timer.start()

# Signal functions
func _on_timer_timeout():
	can_shoot = true
