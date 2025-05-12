class_name LevelBoxContainer extends Node2D

# Export variables
@export var scene_transition: SceneTransition

# Class variables
var current_box: Box
var current_enter_function

# Game functions
func _ready():
	GameManager.box_scene_chaged.connect(change_box)
	if GameManager.init_box_scene:
		GameManager.current_box_scene = GameManager.init_box_scene
	else:
		push_error("No scene to load!")

# Class functions
func change_box(new_box_scene: PackedScene):
	if current_box:
		current_box.queue_free()
		scene_transition.exit_scene()
		# disconnect to prevent creating previous scenes
		if current_enter_function:
			scene_transition.exit_transition_finished.disconnect(current_enter_function)
		current_enter_function = func(): enter_box(new_box_scene)
		scene_transition.exit_transition_finished.connect(current_enter_function)
	else:
		enter_box(new_box_scene)

func enter_box(box_scene: PackedScene):
	if not box_scene:
		push_error("No scene to load!")
		return
	
	# if current_box:
		# current_box.queue_free()
	
	var box := box_scene.instantiate() as Box
	add_child(box)
	current_box = box
	scene_transition.enter_scene()
