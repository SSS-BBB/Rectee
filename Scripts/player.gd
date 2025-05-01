extends CharacterBody2D

@export var speed: int = 300
@export var jump_velocity: int = 400

@onready var health_component = $Health/HealthComponent as HealthComponent

var time_counter: float

func _ready():
	time_counter = 0.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

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
	
	time_counter += delta

func jump(init_velocity: int = 0):
	if init_velocity == 0:
		velocity.y = jump_velocity * -1
	else:
		velocity.y = init_velocity * -1
