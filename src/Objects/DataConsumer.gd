extends StaticBody2D


var open: bool = false

onready var toggle_controller = $ToggleController
onready var corrupted_data_timer: Timer = $CorruptedDataTimer
onready var sprite: Sprite = $DataConsumer

export var corrupted: bool = false
export var circuit_id: int = 0
# How long to wait before counting as uncorrupted
export var wait_time: float = 1

# Set which sides to receive input from
export var top_input: bool = false
export var bottom_input: bool = false
export var left_input: bool = false
export var right_input: bool = false

# Set which sides are still awaiting input
var top_signal: bool = not top_input
var bottom_signal: bool = not bottom_input
var left_signal: bool = not left_signal
var right_signal: bool = not right_signal


func _ready() -> void:
    toggle_controller.circuit_id = circuit_id


func get_input_data_side(data: Data) -> String:
    var sprite_global_position: Vector2 = global_position + sprite.position
    var data_position_to_sprite: Vector2 = data.position - sprite_global_position
    if data_position_to_sprite.y > data_position_to_sprite.x and -data_position_to_sprite.y < data_position_to_sprite.x:
        return 'top'
    elif data_position_to_sprite.y < data_position_to_sprite.x and -data_position_to_sprite.y > data_position_to_sprite.x:
        return 'bottom'
    elif data_position_to_sprite.y > data_position_to_sprite.x and -data_position_to_sprite.y > data_position_to_sprite.x:
        return 'left'
    else:
        return 'right'


func open_if_ready():
    if not open and not corrupted and top_signal and bottom_signal and left_signal and right_signal:
        toggle_controller.set_state(true)
        open = true


func consume_data(data: Data) -> void:
    if data.corrupted:
        corrupted = true
        corrupted_data_timer.start(wait_time)
    else:
        var side = get_input_data_side(data)
        match side:
            'top':
                top_signal = true
            'bottom':
                bottom_signal = true
            'left':
                left_signal = true
            'right':
                right_signal = true
    open_if_ready()


func _on_CorruptedDataTimer_timeout() -> void:
    if corrupted:
        corrupted = false
        open_if_ready()
