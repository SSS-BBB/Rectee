@tool
class_name MovementControlButton extends HudUI

# Game functions
func _ready():
	if not Engine.is_editor_hint():
		always_hide = not UIManager.turn_movement_control_ui
		UIManager.movement_control_setting_changed.connect(func(on: bool): always_hide = not on)
	super._ready()

# Statics
static func do_action_input(action_name: String, check_visible: CanvasItem):
	if not check_visible.visible:
		push_error("Not visible")
		return

	var interact_event = InputEventAction.new()
	interact_event.action = action_name
	interact_event.pressed = true
	Input.parse_input_event(interact_event)

static func do_action_pressed(action_name: String, check_visible: CanvasItem):
	if not check_visible.visible:
		push_error("Not visible")
		return
	
	Input.action_press(action_name)

static func do_action_released(action_name: String):
	Input.action_release(action_name)

# Signal functions
# Pressed
func _on_left_button_button_down():
	do_action_pressed("move_left", self)

func _on_right_button_button_down():
	do_action_pressed("move_right", self)

func _on_up_button_button_down():
	do_action_pressed("move_jump", self)

func _on_down_button_button_down():
	do_action_input("move_down", self)


# Released
func _on_left_button_button_up():
	do_action_released("move_left")

func _on_right_button_button_up():
	do_action_released("move_right")

func _on_up_button_button_up():
	do_action_released("move_jump")

func _on_down_button_button_up():
	do_action_released("move_down")
