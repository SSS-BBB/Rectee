class_name DiedOnTimeoutComponent extends Node2D

# Export variables
@export var dead_time: float = 5.0
@export var health_component: HealthComponent

# Component variables
@onready var timer: Timer = $Timer as Timer

# Class functions
func start_countdown() -> void:
	timer.wait_time = dead_time
	timer.start()

func _on_timer_timeout() -> void:
	health_component.force_die()
	timer.stop()
