class_name Box extends Node2D

# Export variables
@export var box_level: int = 0
@export var endgame_box: bool = false
@export var shaking: bool = false
@export var camera_shaking_component: CameraShakingComponent
@export var door: Door

# Game functions
func _ready():
	UIManager.reset_hud_state_to_none()
	
	GameManager.current_box_level = box_level
	
	if GameManager.current_player_level < box_level:
		GameManager.current_player_level = box_level
	
	if door:
		door.enter_door.connect(_on_enter_door)

func _physics_process(_delta):
	if shaking and camera_shaking_component:
		camera_shaking_component.shake_camera()
		

# Signal functions
func _on_enter_door():
	if endgame_box:
		UIManager.exit_scene_transition(UIManager.show_endgame_ui)
		return
	
	if door.next_box_path.is_empty():
		push_error("No path for next box!")
		return
	
	GameManager.change_box_scene(load(door.next_box_path))
