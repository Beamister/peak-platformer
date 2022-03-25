extends Node

signal player_died
signal score_updated

var score: = 0 setget set_score
var level_score: = 0
var deaths: = 0 setget set_deaths
var ghosts_freed: int = 0
var total_ghosts: int = 0

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
    ghosts_freed = 0
    total_ghosts = 0
    emit_signal("score_updated")


func start_new_level() -> void:
    level_score = score


func reset_level() -> void:
    score = level_score
    emit_signal("score_updated")
