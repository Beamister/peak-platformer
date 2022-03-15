extends TextureButton


func _on_Button_pressed() -> void:
	OS.window_fullscreen = !OS.window_fullscreen
