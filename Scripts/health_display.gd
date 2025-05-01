extends Control


@export var health_component: HealthComponent

@onready var health_bar = $HealthBar as ProgressBar

func _ready():
	health_bar.max_value = health_component.max_health
	health_component.health_update.connect(_on_health_update)

func _on_health_update(health: int):
	health_bar.value = health
