extends StaticBody2D

export var data_entity: PackedScene
export var offset_range: float

onready var timer: Timer = $SpawnTimer
onready var spawn_point: Node2D = $SpawnPoint
onready var level = get_tree().get_nodes_in_group("Levels")[0]

var rng = RandomNumberGenerator.new()


func _on_SpawnTimer_timeout() -> void:
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	var offset_value: float = rng.randf_range(-offset_range, offset_range)
	var offset_vector = Vector2(0, offset_value).rotated(rotation)
	level.spawn_entity(data_entity, spawn_point.global_position + offset_vector, direction)
