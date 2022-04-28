extends Button


func _on_button_up() -> void:
    PlayerData.create_profile("Player_1")
    PlayerData.load_current_level()
