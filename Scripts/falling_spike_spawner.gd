class_name FallingSpikeSpawner extends StaticBody2D

# Export variables
@export var spawn_rate: float = 1.0
@export var spawn_offset: Vector2 = Vector2.DOWN
@export var spawn_on_button_pressed: bool = false

# Component variables
@onready var sprite = $Sprite2D as Sprite2D

# Class variables
var falling_spike_resource_container: Array[SpikeResource] = [
	preload("res://Resources/Spikes/falling_large_spike_1.tres"),
	preload("res://Resources/Spikes/falling_large_spike_2.tres"),
	preload("res://Resources/Spikes/falling_large_spike_3.tres"),
	preload("res://Resources/Spikes/falling_medium_spike_1.tres"),
	preload("res://Resources/Spikes/falling_medium_spike_2.tres"),
	preload("res://Resources/Spikes/falling_small_spike_1.tres"),
	preload("res://Resources/Spikes/falling_small_spike_2.tres"),
	preload("res://Resources/Spikes/falling_small_spike_3.tres"),
]
var falling_spike = preload("res://Scenes/Objects/falling_spike.tscn")
var falling_spike_node_container: Node2D
var time_count: float

# Signals
signal time_left_update # update how much times left before be able to spawn spike again

# Game functions
func _ready():
	falling_spike_node_container = get_tree().get_first_node_in_group("falling_spike_container")
	time_count = 0.0
	time_left_update.emit(max(0, spawn_rate - time_count))

func _process(delta):
	time_count += delta
	time_left_update.emit(max(0, spawn_rate - time_count))
	
	if not spawn_on_button_pressed:
		spawn()

# Class functions
func spawn():
	if time_count < spawn_rate:
		return
	
	if not falling_spike_node_container:
		return
	# spawn randomly
	var spawned_falling_spike := falling_spike.instantiate() as FallingSpike
	spawned_falling_spike.resource = falling_spike_resource_container.pick_random()
		
	# set position
	spawned_falling_spike.global_position = global_position
	var H = spawned_falling_spike.resource.texture_region.size.y * scale.y
	var h = sprite.region_rect.size.y * scale.y
	spawned_falling_spike.global_position.y += (H + h) / 2.0
	spawned_falling_spike.global_position += spawn_offset
		
	spawned_falling_spike.scale = scale
	falling_spike_node_container.add_child(spawned_falling_spike)
	
	time_count = 0.0
