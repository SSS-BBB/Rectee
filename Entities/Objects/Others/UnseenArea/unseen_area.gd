class_name UnseenArea extends Node2D

# Export variables
@export var direction_to_show: AreaEnterComponent.EnterTo = AreaEnterComponent.EnterTo.RIGHT # which enter direction to show the area
@export var to_hide_on_enter: Array[UnseenArea] # other unseen area to hide when enter the area
@export var to_show_on_exit: Array[UnseenArea] # other unseen area to show when exit the area

# Component variables
@onready var hidden_area = $HiddenArea as Control
@onready var enter_area_audio = $EnterAreaAudio as AudioStreamPlayer2D
@onready var exit_area_audio = $ExitAreaAudio as AudioStreamPlayer2D

# Class functions
func start_modulate(modulate_value: float, audio: AudioStreamPlayer2D, mute: bool = false):
	var tween := get_tree().create_tween()
	tween.tween_property(hidden_area, "modulate:a", modulate_value, audio.stream.get_length())
	tween.bind_node(self)
	if not mute:
		audio.play()

# Signal functions
func _on_area_enter_component_target_enter_area(enter_to: AreaEnterComponent.EnterTo):
	if direction_to_show == enter_to:
		start_modulate(0.0, enter_area_audio)
	
		for to_hide in to_hide_on_enter:
			to_hide.start_modulate(1.0, to_hide.exit_area_audio, true)
		
	elif enter_to == AreaEnterComponent.get_opposite(direction_to_show):
		start_modulate(1.0, exit_area_audio)
		
		for to_show in to_show_on_exit:
			to_show.start_modulate(0.0, to_show.enter_area_audio, true)
