extends Button


var save_data: Dictionary


func _ready() -> void:
    yield(get_tree().root, "ready")
    if not PlayerData.profile_is_set():
        queue_free()


func _on_button_up() -> void:
    PlayerData.load_current_level()
