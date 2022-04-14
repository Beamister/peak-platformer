extends Node

signal player_died
signal score_updated

var score: = 0 setget set_score
var level_score: = 0
var deaths: = 0 setget set_deaths
var total_ghosts_freed: int = 0
var level_ghosts_freed: int = 0


func set_score(value: int) -> void:
    score = value
    emit_signal("score_updated")


func set_deaths(value: int) -> void:
    deaths = value
    emit_signal("player_died")


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


func start_new_level() -> void:
    level_score = score
    level_ghosts_freed = 0 


func reset_level() -> void:
    score = level_score
    total_ghosts_freed -= level_ghosts_freed
    emit_signal("score_updated")
