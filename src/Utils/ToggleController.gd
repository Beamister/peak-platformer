extends Node

signal toggled_state(switch_id, state)

export var circuit_id: int = 0 setget , get_circuit_id

var state: bool = 0 setget set_state


func get_circuit_id() -> int:
	return circuit_id


func set_state(new_state: bool) -> void:
	if new_state != state:
		toggle_state()
	state = new_state


func toggle_state() -> void:
	state = !state
	emit_signal("toggled_state", circuit_id, state)
