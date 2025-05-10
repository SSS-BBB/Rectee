class_name BouncingPlatform extends Node2D

# Export variables
@export var do_tween: bool = true
@export_group("Tween Property")
@export var bouncing_duration: float = 0.8
@export var bouncing_offset: float = 8.0

# Component variables
@onready var platform_body = $AnimatableBody2D as AnimatableBody2D
@onready var animation_player = $AnimationPlayer as AnimationPlayer

# Class variables
var slide: float # how much does y change in each frame
var frame_time: float
var bouncing: bool

# Game functions
func _ready():
	slide = bouncing_offset / 2.0
	frame_time = bouncing_duration / 4.0
	bouncing = false

# Signal functions
func _on_trigger_area_body_entered(body: CharacterBody2D):
	if body.is_in_group("player") and not bouncing:
		bounce()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "bounce":
		bouncing = false

# Class functions
func bounce():
	bouncing = true
	if do_tween:
		var tween = get_tree().create_tween()
		tween.tween_property(platform_body, "position:y", slide, frame_time)
		tween.tween_property(platform_body, "position:y", bouncing_offset, frame_time)
		tween.tween_property(platform_body, "position:y", slide, frame_time)
		tween.tween_property(platform_body, "position:y", 0, frame_time)
		tween.tween_callback(func(): bouncing = false) # reset bouncing to false after finished animating
		tween.bind_node(self)
	else:
		animation_player.play("bounce")
