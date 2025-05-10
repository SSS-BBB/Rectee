class_name UnseenArea extends Node2D

# Export variables
@export var direction_to_show: AreaEnterComponent.EnterTo = AreaEnterComponent.EnterTo.RIGHT # which enter direction to show the area

# Component variables
@onready var hidden_area = $HiddenArea as Control
@onready var enter_area_audio = $EnterAreaAudio as AudioStreamPlayer2D
@onready var exit_area_audio = $ExitAreaAudio as AudioStreamPlayer2D

func _on_area_enter_component_target_enter_area(enter_to: AreaEnterComponent.EnterTo):
	if direction_to_show == enter_to:
		var tween := get_tree().create_tween()
		tween.tween_property(hidden_area, "modulate:a", 0.0, enter_area_audio.stream.get_length())
		tween.bind_node(self)
		enter_area_audio.play()
	elif enter_to == AreaEnterComponent.get_opposite(direction_to_show):
		var tween := get_tree().create_tween()
		tween.tween_property(hidden_area, "modulate:a", 1.0, exit_area_audio.stream.get_length())
		tween.bind_node(self)
		exit_area_audio.play()
