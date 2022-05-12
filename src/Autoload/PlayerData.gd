extends Node

signal player_died
signal score_updated
signal query_pieces_updated

var score: int = 0 setget set_score
var level_score: = 0
var deaths: int = 0 setget set_deaths
var total_ghosts_freed: int = 0
var level_ghosts_freed: int = 0
var query_pieces: int = 0 setget set_query_pieces

var current_level_index: int = 0
var game_data: GameData
var level_map: LevelMap


func set_score(value: int) -> void:
    score = value
    emit_signal("score_updated")


func set_deaths(value: int) -> void:
    deaths = value
    emit_signal("player_died")


func set_query_pieces(value: int) -> void:
    query_pieces = value
    emit_signal("query_pieces_updated")


func reset_game() -> void:
    level_score = 0
    score = 0
    deaths = 0
    total_ghosts_freed = 0
    level_ghosts_freed = 0
    emit_signal("score_updated")


func free_ghost() -> void:
    level_ghosts_freed += 1
    total_ghosts_freed += 1


func set_game_state(score_value: int, deaths_value: int, ghosts_freed_value: int) -> void:
    level_score = 0
    score = score_value
    deaths = deaths_value
    total_ghosts_freed = ghosts_freed_value
    level_ghosts_freed = 0
    emit_signal("score_updated")


func set_game_state_from_profile(player_profile: PlayerProfile) -> void:
    set_game_state(player_profile.get_score(), player_profile.get_deaths(), player_profile.get_ghosts_freed())


func save_game_state_to_profile(player_profile: PlayerProfile) -> void:
    player_profile.set_score(score)
    player_profile.set_deaths(deaths)
    player_profile.set_ghosts_freed(total_ghosts_freed)


func start_new_level() -> void:
    level_score = score
    level_ghosts_freed = 0 


func reset_level() -> void:
    score = level_score
    total_ghosts_freed -= level_ghosts_freed
    level_ghosts_freed = 0
    emit_signal("score_updated")


func get_level_count() -> int:
    return level_map.levels.size()


func load_level(level_index: int) -> void:
    current_level_index = level_index
    var next_level: PackedScene = level_map.get_level(current_level_index)
    get_tree().change_scene_to(next_level)


func load_current_level() -> void:
    load_level(current_level_index)


func load_next_level() -> void:
    load_level(current_level_index + 1)


func has_next_level() -> bool:
    return current_level_index < level_map.get_level_count() - 1


func create_profile(profile_name: String) -> void:
    game_data.create_profile(profile_name)
    game_data.set_current_profile(profile_name)
    set_game_state_from_profile(game_data.get_current_profile())
    current_level_index = game_data.get_current_profile().get_last_level_index()


func profile_is_set() -> bool:
    return game_data.current_profile_is_set()


func load_game() -> void:
    var dir = Directory.new()
    dir.remove("user://savegame.save")
    level_map = ResourceLoader.load("res://assets/data/level_map.tres")
    if dir.file_exists("user://savegame.save"):
        game_data = ResourceLoader.load("user://savegame.save")
    else:
        game_data = GameData.new(level_map.get_level_count())


func save_game() -> void:
    save_game_state_to_profile(game_data.get_current_profile())
    ResourceSaver.save("user://savegame.save", game_data)
