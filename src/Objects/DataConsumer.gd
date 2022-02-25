extends StaticBody2D


var open: bool = false
var corrupted: bool = true

onready var toggle_controller = $ToggleController
onready var corrupted_data_timer: Timer = $CorruptedDataTimer

export var circuit_id: int = 0
export var wait_time: float = 0

func _ready() -> void:
	toggle_controller.circuit_id = circuit_id
	corrupted_data_timer.start(wait_time)


func consume_data(data: Data) -> void:
	if data.corrupted:
		corrupted = true
		corrupted_data_timer.start(wait_time)
	elif not open and not corrupted:
		toggle_controller.set_state(true)
		open = true


func _on_CorruptedDataTimer_timeout() -> void:
	corrupted = false
	toggle_controller.set_state(true)
	open = true
