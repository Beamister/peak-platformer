extends Area2D
class_name Data

var velocity: Vector2 = Vector2.ZERO
var speed: float = 3
var corrupted: bool = false

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var label: Label = $Label

func _physics_process(delta: float) -> void:
	position += velocity


func spawn(_position: Vector2, _direction: Vector2, metadata: Dictionary) -> void:
	velocity = _direction * speed
	position = _position
	if metadata.has('corrupted') and metadata['corrupted']:
		corrupted = metadata['corrupted']
		label.set("custom_colors/font_color", Color("#ff3c82"))
	var animation_offset: float = rand_range(0, animation_player.current_animation_length)
	animation_player.advance(animation_offset)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	label.text = String(rng.randi_range(0, 1))


func _on_Data_body_entered(body: Node) -> void:
	if body.has_method('consume_data'):
		body.consume_data(self)
	disappear()


func disappear() -> void:
	queue_free()


func _on_Data_area_entered(area: Area2D) -> void:
	disappear()
