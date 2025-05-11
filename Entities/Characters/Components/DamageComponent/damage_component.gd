class_name DamageComponent extends Node2D

# Export variables
@export var health_component: HealthComponent
@export var actor: PhysicsBody2D
@export var damage_audio: AudioStreamPlayer2D
@export_range(0.0, 1.0, 0.01) var volume_percentage: float = 1.0
@export var hit_animation_player: AnimationPlayer
@export var hit_animation_name: String
@export var knockback_deceleration: float = 25.0

# Class functions
var current_knockback_direction: Vector2
var current_knockback_force: float

# Game functions
func _ready():
	current_knockback_direction = Vector2.ZERO
	current_knockback_force = 0.0
	
	if damage_audio:
		# set audio volume
		damage_audio.volume_db = linear_to_db(volume_percentage)

func _physics_process(delta):
	if current_knockback_direction == Vector2.ZERO or current_knockback_force <= 0.0:
		return
	actor.position += current_knockback_direction * current_knockback_force * delta
	if actor is CharacterBody2D:
		actor.move_and_slide()
	
	current_knockback_force = move_toward(current_knockback_force, 0.0, knockback_deceleration * delta)

# Class functions
func take_damage(damage: int, knockback_direction: Vector2 = Vector2.ZERO, knockback_force: float = 0.0):
	health_component.take_damage(damage)
	current_knockback_direction = knockback_direction
	current_knockback_force = knockback_force
	
	if damage_audio:
		damage_audio.play()
	
	if hit_animation_player and not hit_animation_name.is_empty():
		hit_animation_player.play(hit_animation_name)
