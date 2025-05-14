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
	if damage < 0:
		push_warning("Damage less than 0. This might cause actor to gaining health instead of losing health. If you want actor to gain health, you should use gain_health method instead.")
	
	health -= damage
	damage_signal.emit(damage)
	if health <= 0:
		actor_die.emit()
		health = 0
	health_update.emit(health)
	
func gain_health(health_gain: int) -> bool:
	if health_gain < 0:
		push_warning("Health gain less than 0. This might cause actor to losing health instead of gaining health. If you want actor to lose health, you should use take_damage method instead.")
	
	if health >= max_health:
		health_update_failed.emit("[FullHP]")
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
