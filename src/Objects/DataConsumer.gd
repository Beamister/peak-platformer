extends StaticBody2D


var open: bool = false

onready var toggle_controller = $ToggleController
export var circuit_id: int = 0

func _ready() -> void:
	toggle_controller.circuit_id = circuit_id

func consume_data() -> void:
	if open == false:
		toggle_controller.set_state(true)
		open = true
