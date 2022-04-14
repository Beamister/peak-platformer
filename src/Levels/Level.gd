extends Node2D


func _ready() -> void:
    save_game()


func spawn_entity(entity_object, _position, _direction, metadata={}) -> void:
    var new_entity = entity_object.instance()
    add_child(new_entity)
    new_entity.spawn(_position, _direction, metadata)


func save_game() -> void:
    var save_game: File = File.new()
    save_game.open("user://savegame.save", File.WRITE)
    var save_data: Dictionary = {
        "level": get_tree().current_scene.filename,
        "score": PlayerData.score,
        "deaths": PlayerData.deaths,
        "ghosts_freed": PlayerData.ghosts_freed
       }
    save_game.store_line(to_json(save_data))
    save_game.close()
