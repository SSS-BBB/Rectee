class_name SpikeSpawnButton extends Area2D

# Export variables
@export var spike_spawner: FallingSpikeSpawner # this button connects to this spike spawner

# Component variables
@onready var on_interact_component = $OnInteractComponent as OnInteractComponent
@onready var time_display = $UIs/TimeDisplay as TimeDisplay

# Game functions
func _ready():
	if spike_spawner:
		on_interact_component.interact.connect(func(): spike_spawner.spawn())
		spike_spawner.time_left_update.connect(func(t): time_display.change_time(t))
