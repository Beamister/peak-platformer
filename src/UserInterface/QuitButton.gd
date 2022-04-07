extends Button


func _on_button_up() -> void:
    get_tree().quit()


func _ready() -> void:
    var os_name = OS.get_name()
    if os_name == "HTML5":
        queue_free()
