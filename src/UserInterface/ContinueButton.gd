extends Button


var save_data: Dictionary


func _ready() -> void:
    var save_game = File.new()
    if not save_game.file_exists("user://savegame.save"):
        queue_free()
    else:
        save_game.open("user://savegame.save", File.READ)
        save_data = parse_json(save_game.get_as_text())


func _on_button_up() -> void:
    print(save_data)
    PlayerData.set_game_state(save_data["score"], save_data["deaths"], save_data["ghosts_freed"])
    var level_scene = load(save_data["level"])
    get_tree().change_scene_to(level_scene)
