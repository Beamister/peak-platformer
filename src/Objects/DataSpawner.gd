extends StaticBody2D

signal spawn_data

export var data_object: PackedScene

onready var timer: Timer = $SpawnTimer
onready var spawn_point: Node2D = $SpawnPoint

func _on_SpawnTimer_timeout() -> void:
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	emit_signal('spawn_data', data_object, spawn_point.global_position, direction)
