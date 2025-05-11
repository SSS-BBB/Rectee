class_name Box extends Node2D

# Export variables
@export var box_level: int = 0
@export var shaking: bool = false
@export var camera_shaking_component: CameraShakingComponent

# Component variables
@onready var scene_transition = $SceneTransition as SceneTransition
@onready var door = $Door as Door

# Game functions
func _ready():
	GameManager.current_box_level = box_level
	
	if scene_transition:
		scene_transition.enter_scene()
		scene_transition.exit_transition_finished.connect(_on_exit_transition_finished)
	
	if door:
		door.enter_door.connect(_on_enter_door)

func _physics_process(_delta):
	if shaking and camera_shaking_component:
		camera_shaking_component.shake_camera()
		

# Signal functions
func _on_enter_door():
	if scene_transition:
		scene_transition.exit_scene()

func _on_exit_transition_finished():
	if not door.next_scence_path.is_empty():
		get_tree().change_scene_to_file(door.next_scence_path)
