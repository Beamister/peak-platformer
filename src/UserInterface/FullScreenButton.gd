extends TextureButton


func _ready() -> void:
	var os_name = OS.get_name()
	if os_name == "Android" or os_name == "iOS":
		visible = false

func _on_Button_pressed() -> void:
	OS.window_fullscreen = !OS.window_fullscreen
	release_focus()
