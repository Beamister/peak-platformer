extends TextureButton

func _on_Button_button_up() -> void:
    var new_action: InputEventAction = InputEventAction.new()
    new_action.action = "move_left"
    new_action.pressed = false
    Input.parse_input_event(new_action)


func _on_Button_button_down() -> void:
    var new_action: InputEventAction = InputEventAction.new()
    new_action.action = "move_left"
    new_action.pressed = true
    Input.parse_input_event(new_action)
