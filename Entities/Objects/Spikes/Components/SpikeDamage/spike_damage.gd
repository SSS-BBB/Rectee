class_name SpikeDamage extends Node2D

# Export variables
@export var spike: Spike

# Game functions
func _get_configuration_warnings():
	var warnings: Array[String] = []
	if not spike:
		warnings.append("Warning: No spike added to this component.")
		
	return warnings

# Class functions
func hit_player(player: Player):
	var damage := spike.resource.damage
	var knockback_power := 400.0 + damage * 50.0 # TODO: knockback in resource
	player.take_spike_damage(damage, spike.global_position, knockback_power)

func hit(node_position: Vector2, damage_component: DamageComponent):
	var damage := spike.resource.damage
	var knockback_power := 30.0 + damage * 2.0
	damage_component.take_damage(damage, spike.global_position.direction_to(node_position), knockback_power)
