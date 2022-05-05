extends Area2D
class_name Data

var velocity: Vector2 = Vector2.ZERO
var speed: float = 3
var corrupted: bool = false
var color: int = Enums.DATA_COLORS.BLACK

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var label: Label = $Label

func _physics_process(delta: float) -> void:
    position += velocity


func set_data_color(color_enum: int) -> void:
    color = color_enum
    var color_value: Color
    if color_enum == Enums.DATA_COLORS.BLACK:
        color_value = Constants.BLACK
    elif color_enum == Enums.DATA_COLORS.RED:
        color_value = Constants.RED
    elif color_enum == Enums.DATA_COLORS.BLUE:
        color_value = Constants.BLUE
    elif color_enum == Enums.DATA_COLORS.YELLOW:
        color_value = Constants.YELLOW
    elif color_enum == Enums.DATA_COLORS.GREEN:
        color_value = Constants.GREEN
    label.set("custom_colors/font_color", color_value)


func spawn(_position: Vector2, _direction: Vector2, metadata: Dictionary) -> void:
    velocity = _direction * speed
    position = _position
    if metadata.has('corrupted') and metadata['corrupted']:
        corrupted = metadata['corrupted']
    if metadata.has('color'):
        set_data_color(metadata['color'])
    var animation_offset: float = rand_range(0, animation_player.current_animation_length)
    animation_player.advance(animation_offset)
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    label.text = String(rng.randi_range(0, 1))


func get_data_color() -> int:
    return color


func _on_Data_body_entered(body: Node) -> void:
    if body.has_method('consume_data'):
        body.consume_data(self)
    disappear()


func disappear() -> void:
    queue_free()


func _on_Data_area_entered(area: Area2D) -> void:
    disappear()
