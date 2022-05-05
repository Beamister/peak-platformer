extends StaticBody2D

export var data_entity: PackedScene
export var offset_range: float
export var corrupted: bool = false
export(Enums.DATA_COLORS) var data_color = Enums.DATA_COLORS.BLACK
export var has_hidden_color: bool = false
export(Enums.DATA_COLORS) var hidden_color = Enums.DATA_COLORS.BLACK
export(Enums.DIRECTIONS) var data_direction = Enums.DIRECTIONS.RIGHT

onready var timer: Timer = $SpawnTimer
onready var up_spawn_point: Node2D = $UpSpawnPoint
onready var down_spawn_point: Node2D = $DownSpawnPoint
onready var left_spawn_point: Node2D = $LeftSpawnPoint
onready var right_spawn_point: Node2D = $RightSpawnPoint
onready var level = get_tree().get_nodes_in_group("Levels")[0]

var rng = RandomNumberGenerator.new()


func _ready() -> void:
    if corrupted:
        data_color = Enums.DATA_COLORS.RED


func _on_SpawnTimer_timeout() -> void:
    var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
    var offset_value: float = rng.randf_range(-offset_range, offset_range)
    var spawn_point: Node2D
    var offset_vector: Vector2
    if data_direction == Enums.DIRECTIONS.RIGHT:
        direction = Vector2.RIGHT
        spawn_point = right_spawn_point
        offset_vector = Vector2(0, offset_value)
    elif data_direction == Enums.DIRECTIONS.LEFT:
        direction = Vector2.LEFT
        spawn_point = left_spawn_point
        offset_vector = Vector2(0, offset_value)
    elif data_direction == Enums.DIRECTIONS.UP:
        direction = Vector2.UP
        spawn_point = up_spawn_point
        offset_vector = Vector2(offset_value, 0)
    else:
        direction = Vector2.DOWN
        spawn_point = down_spawn_point
        offset_vector = Vector2(offset_value, 0)
    var metadata = {}
    if corrupted:
        metadata['corrupted'] = true
    metadata['color'] = data_color
    level.spawn_entity(data_entity, spawn_point.global_position + offset_vector, direction, metadata)


func set_data_color(new_data_color: int):
    data_color = new_data_color
