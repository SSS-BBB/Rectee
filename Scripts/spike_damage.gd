class_name SpikeDamage extends Node2D

# Export variables
@export var spike: Spike
@export var hitbox: SpikeHitbox

# Game functions
func _ready():
	hitbox.hit_area.body_entered.connect(_on_hit_area_body_enter)

# Signal functions
func _on_hit_area_body_enter(body: Node2D):
	if body.is_in_group("player"):
		var player := body as Player
		var damage := spike.resource.damage
		var knockback_power := 400.0 + damage * 50.0 # TODO: knockback in resource
		player.take_spike_damage(damage, spike.global_position, knockback_power)
