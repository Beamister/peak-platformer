class_name LevelMap
extends Resource

export(Array, PackedScene) var levels

export(Array, int) var stage_level_counts


func get_level(level_index: int) -> PackedScene:
    return levels[level_index]


func get_level_count() -> int:
    return levels.size()
