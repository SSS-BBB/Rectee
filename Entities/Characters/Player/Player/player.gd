class_name Player extends CharacterBody2D

# Exports
@export var normal_speed: int = 300
@export var normal_jump_velocity: int = 400
@export var knockback_deceleration: int = 25

# Components
@onready var health_component = $Health/HealthComponent as HealthComponent
@onready var effect_component = $EffectComponent as EffectComponent

@onready var sprite = $Sprite as AnimatedSprite2D

@onready var spike_damage_audio = $SFXs/SpikeDamageAudio as AudioStreamPlayer2D
@onready var bullet_damage_audio = $SFXs/BulletDamageAudio as AudioStreamPlayer2D
@onready var drinking_audio = $SFXs/DrinkingAudio as AudioStreamPlayer2D
@onready var landing_audio = $SFXs/LandingAudio as AudioStreamPlayer2D
@onready var key_retrive_audio = $SFXs/KeyRetriveAudio as AudioStreamPlayer2D

# Player variables
var time_counter: float
var speed: int
var jump_velocity: int
var knockback_power: float
var knockback_power_max: float
var knockback_direction: Vector2
var keys: int:
	set(keys_update):
		# Keys retrived
		if keys_update > keys:
			key_retrive_audio.play()
		keys = keys_update

# Game functions
func _ready():
	time_counter = 0.0
	keys = 0
	knockback_power = 0
	health_component.damage_signal.connect(_on_take_damage)

func _input(event):
	if event.is_action_pressed("move_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)

func _physics_process(delta):
	update_variables()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if knockback_power > knockback_power_max / 2.0:
		# if there is knockback, we will not listen to the input
		knockback_process(delta)
		return
	
	handle_process_input(delta)

# Class functions
func update_variables():
	# set variables
	speed = normal_speed + effect_component.extra_speed
	jump_velocity = normal_jump_velocity + effect_component.extra_jump

func handle_process_input(_delta):
	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		jump()

	# Handle movement in x direction
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func knockback_process(_delta):
	velocity = knockback_direction * knockback_power
	knockback_power = move_toward(knockback_power, 0, knockback_deceleration)
	move_and_slide()

func time_loop(delta):
	# do logic every fixed time
	if time_counter >= 1.5:
		time_counter = 0
	
	time_counter += delta

func jump(init_velocity: int = 0):
	if init_velocity == 0:
		velocity.y = jump_velocity * -1
	else:
		velocity.y = init_velocity * -1
		
func knockback(object_position: Vector2, knockback_force: float):
	knockback_direction = object_position.direction_to(global_position)
	knockback_power = knockback_force
	knockback_power_max = knockback_force

func take_damage(damage: int, object_position: Vector2, knockback_force: float):
	health_component.take_damage(damage)
	knockback(object_position, knockback_force)

func take_spike_damage(damage: int, object_position: Vector2, knockback_force: float):
	take_damage(damage, object_position, knockback_force)
	spike_damage_audio.play()

func take_bullet_damage(damage: int, object_position: Vector2, knockback_force: float):
	take_damage(damage, object_position, knockback_force)
	bullet_damage_audio.play()
	
func take_consumable(consumable_resource: ConsumableResource) -> bool:
	var effect_applied := effect_component.apply_effect(consumable_resource)
	if not effect_applied:
		return false
	
	drinking_audio.play()
	return true

# Signal functions
func _on_take_damage(_damage):
	sprite.play("damaged")

func _on_sprite_animation_finished():
	if sprite.animation == "damaged":
		sprite.play("default")

func _on_health_component_actor_die():
	UIManager.show_died_ui()
