extends Node2D
class_name HealthComponent

# export variables
@export var max_health: int = 15

# variables
var health: int

# signal
signal actor_die
signal health_update
signal damage_signal
signal health_update_failed

func _ready():
	health = max_health
	health_update.emit(health)
	
func take_damage(damage: int):
	health -= damage
	damage_signal.emit(damage)
	if health <= 0:
		actor_die.emit()
		health = 0
	health_update.emit(health)
	
func gain_health(health_gain: int) -> bool:
	if health >= max_health:
		health_update_failed.emit("FullHP")
		return false
	
	health += health_gain
	
	if health <= 0:
		actor_die.emit()
		health = 0
	if health > max_health:
		health = max_health
		
	health_update.emit(health)
	return true

func update_max_health(value: int, update_health: bool = true):
	max_health = value
	if update_health:
		health = max_health
	
	health_update.emit(health)
