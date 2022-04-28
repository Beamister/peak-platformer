class_name PlayerProfile
extends Resource

var score: int = 0
var deaths: int = 0
var ghosts_freed: int = 0
var level_data: Array = []
var last_level_index = 0


func _init(level_count: int) -> void:
    level_data = []
    for level_index in range(level_count):
        level_data.append(LevelPlayerData.new())


func get_last_level_index() -> int:
    return last_level_index


func get_score() -> int:
    return score


func get_deaths() -> int:
    return deaths


func get_ghosts_freed() -> int:
    return ghosts_freed


func set_score(new_score: int) -> void:
    score = new_score


func set_deaths(new_deaths: int) -> void:
    deaths = new_deaths


func set_ghosts_freed(new_ghosts_freed: int) -> void:
    ghosts_freed = new_ghosts_freed


func set_level_data(new_level_data: Array) -> void:
    level_data = new_level_data
