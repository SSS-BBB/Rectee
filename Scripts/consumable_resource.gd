class_name ConsumableResource extends Resource

@export var texture: Texture2D
@export var get_audio: AudioStream
@export var effect: Effect
@export var value: int
@export var duration: float

enum Effect {
	SPEED, JUMP, HEALTH
}
