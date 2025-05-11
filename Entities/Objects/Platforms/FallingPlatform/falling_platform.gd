class_name FallingPlatform extends Node2D

# Export variables
@export var time_to_fall: float = 1.0 # how much time before the platform starts falling
@export_group("Shaking Property")
@export var shaking_offset: float = 1.0

# Component variables
@onready var animation_player = $AnimationPlayer as AnimationPlayer
@onready var platform_body = $AnimatableBody2D as AnimatableBody2D
@onready var shaking_audio = $ShakingAudio as AudioStreamPlayer2D

# Class variables
var falling: bool
var shaking: bool
var shake_time: float

# Game functions
func _ready():
	falling = false
	shaking = false

func _process(delta):
	if shaking:
		# Shaking before falling
		platform_body.position = Vector2(randf_range(-shaking_offset, shaking_offset), randf_range(-shaking_offset, shaking_offset))
		shake_time += delta
		
		# Finished shaking
		if shake_time >= time_to_fall:
			shaking = false
			falling = true
			animation_player.play("fall")

# Signal functions
func _on_fall_trigger_area_body_entered(body: CharacterBody2D):
	if body.is_in_group("player") and not falling and not shaking:
		shake_time = 0.0
		shaking = true
		var audio_time = shaking_audio.stream.get_length() - time_to_fall
		audio_time = max(0, audio_time)
		shaking_audio.play(audio_time) # play audio as long as falling

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fall":
		falling = false
		call_deferred("queue_free")
