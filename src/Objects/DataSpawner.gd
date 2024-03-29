extends StaticBody2D

export var data_entity: PackedScene
export var offset_range: float = 30.0
export var corrupted: bool = false
export(Enums.DATA_COLORS) var data_color = Enums.DATA_COLORS.BLACK
export var has_hidden_color: bool = false
export(Enums.DATA_COLORS) var hidden_color = Enums.DATA_COLORS.BLACK
export(Enums.DIRECTIONS) var data_direction = Enums.DIRECTIONS.RIGHT
export var required_query_pieces: int = 0
export var circuit_id: int = -1

onready var timer: Timer = $SpawnTimer
onready var up_spawn_point: Node2D = $UpSpawnPoint
onready var down_spawn_point: Node2D = $DownSpawnPoint
onready var left_spawn_point: Node2D = $LeftSpawnPoint
onready var right_spawn_point: Node2D = $RightSpawnPoint
onready var level = get_tree().get_nodes_in_group("Levels")[0]

var toggle_count: int  = 0
var enabled = true
var rng = RandomNumberGenerator.new()


func _ready() -> void:
    if circuit_id != -1:
        enabled = false
        find_switch(circuit_id)
    if corrupted:
        data_color = Enums.DATA_COLORS.RED


func _on_SpawnTimer_timeout() -> void:
    if enabled:
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


func _on_PlayerDetector_body_entered(body: Node) -> void:
    if has_hidden_color and body.name == "Player" and PlayerData.query_pieces == required_query_pieces:
        Events.emit_signal("query_pieces_cleared")
        set_data_color(hidden_color)


func find_switch(id: int) -> void:
    var err: int = 0
    var toggles = get_tree().get_nodes_in_group("Toggles")
    for toggle in toggles:
        if toggle.circuit_id == id:
            if toggle.is_connected("toggled_state", self, "trigger_switch_toggled") == false:
                err = toggle.connect("toggled_state", self, "trigger_switch_toggled")
                toggle_count += 1


func trigger_switch_toggled(id: int, state: bool) -> void:
    # Make sure it was the switch that is associated with this door
    if id == circuit_id:
        toggle_count -= 1
        if toggle_count == 0:
            enabled = true

