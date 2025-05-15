class_name DialogArea extends Area2D

# Export variables
@export var target_group: String = "player"
@export var dialog_data: Array[DialogData]

# Signal functions
func _on_body_entered(body: Node2D):
	if not body.is_in_group(target_group):
		return
	
	if not dialog_data:
		push_error("No dialog data assigned!")
		return
	
	UIManager.show_dialog_ui(dialog_data)
	queue_free()
