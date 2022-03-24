extends TextureButton


func _on_Button_pressed() -> void:
	var new_action: InputEventAction = InputEventAction.new()
	new_action.action = "pause"
	new_action.pressed = true
	Input.parse_input_event(new_action)
	release_focus()
