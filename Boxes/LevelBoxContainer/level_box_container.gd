class_name LevelBoxContainer extends Node2D

# Export variables
@export var scene_transition: SceneTransition

# Class variables
var current_box: Box
var current_enter_function

# Game functions
func _ready():
	GameManager.box_container = self
	
	if GameManager.init_box_scene:
		GameManager.change_box_scene(GameManager.init_box_scene)
	else:
		push_error("No scene to load!")

# Class functions
func change_box(new_box_scene: PackedScene):
	if current_box:
		# Audio
		AudioManager.play_door_audio()
		await exit_current_box()
	
	enter_box(new_box_scene)

func reload_box(box_scene: PackedScene):
	if not current_box or not box_scene:
		push_error("No scene to reload!")
		return
	
	await exit_current_box()
	enter_box(box_scene)

func enter_box(new_box_scene: PackedScene):
	if not new_box_scene:
		push_error("No box to enter!")
		return
	
	var box := new_box_scene.instantiate() as Box
	add_child(box)
	current_box = box
	scene_transition.enter_scene()

func exit_current_box():
	current_box.queue_free()
	scene_transition.exit_scene()
	await scene_transition.exit_transition_finished
