extends Button


var save_data: Dictionary


func _ready() -> void:
    var save_game = File.new()
    if not save_game.file_exists("user://savegame.save"):
        queue_free()
    else:
        save_game.open("user://savegame.save", File.READ)
        var save_file_string: String = save_game.get_as_text()
        var parsed_save_string = parse_json(save_file_string)
        if typeof(parsed_save_string) == TYPE_DICTIONARY:
            save_data = parsed_save_string
        else:
            # Delete save file if invalid
            var dir = Directory.new()
            dir.remove("user://savegame.save")


func _on_button_up() -> void:
    print(save_data)
    PlayerData.set_game_state(save_data["score"], save_data["deaths"], save_data["ghosts_freed"])
    var level_scene = load(save_data["level"])
    get_tree().change_scene_to(level_scene)
