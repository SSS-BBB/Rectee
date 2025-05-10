class_name EffectComponent extends Node2D

# Exports
@export var health_component: HealthComponent

# Components
@onready var speed_timer = $SpeedTimer as Timer
@onready var jump_timer = $JumpTimer as Timer

# Effect variables
var extra_speed: int
var extra_jump: int

# Game functions
func _ready():
	extra_speed = 0
	extra_jump = 0

# Class functions
func apply_effect(consume_item: ConsumableResource) -> bool:
	match consume_item.effect:
		ConsumableResource.Effect.SPEED:
			extra_speed += consume_item.value
			start_timer(speed_timer, consume_item.duration)
			return true
		ConsumableResource.Effect.JUMP:
			extra_jump += consume_item.value
			start_timer(jump_timer, consume_item.duration)
			return true
		ConsumableResource.Effect.HEALTH:
			return health_component.gain_health(consume_item.value)
	
	return false

func start_timer(timer: Timer, wait_time: float):
	if timer.is_stopped():
		timer.wait_time = wait_time
	else:
		timer.wait_time = timer.time_left + wait_time
		timer.stop()
	timer.start()

# Signal functions
func _on_speed_timer_timeout():
	extra_speed = 0

func _on_jump_timer_timeout():
	extra_jump = 0
