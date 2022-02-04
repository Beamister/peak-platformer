extends StaticBody2D

signal switch_toggled(switch_id)
 
export var switch_id: int = 0 setget , get_switch_id

var open: bool = false


func get_switch_id() -> int:
	return switch_id


func consume_data() -> void:
	if open == false:
		open = true
		emit_signal("switch_toggled", switch_id)
