extends Actor


export var stomp_impulse: = 600.0
export var max_y_head_movement: float = 15
export var max_x_head_movement: float = 5
export var head_movement_factor: float = 10
export var zoom_speed: float = 2

onready var jump_audio_player: AudioStreamPlayer = $JumpAudioStreamPlayer
onready var death_audio_player: AudioStreamPlayer = $DeathAudioStreamPlayer
onready var power_up_timer: Timer = $PowerUpTimer
onready var head: CollisionShape2D = $HeadCollisionShape
onready var query_label: Label = $QueryLabel
onready var camera: Camera2D = $Camera2D

onready var base_speed: Vector2 = speed

onready var base_head_position: Vector2 = head.position

var query_text_segments: PoolStringArray = []
var target_zoom: float = 1.0

func _ready() -> void:
    Events.connect("query_piece_acquired", self, "_on_query_piece_acquired")
    Events.connect("query_pieces_cleared", self, "_on_query_pieces_cleared")
    Events.connect("update_camera_zoom", self, "_on_update_camera_zoom")
    Events.connect("reset_camera", self, "_on_reset_camera")


func _on_update_camera_zoom(new_zoom_scale: float) -> void:
    target_zoom = new_zoom_scale


func _on_reset_camera() -> void:
    target_zoom = 1.0


func _on_query_piece_acquired(query_text, query_text_index) -> void:
    while query_text_segments.size() - 1 < query_text_index:
        query_text_segments.append("")
    query_text_segments[query_text_index] = query_text
    query_label.text = query_text_segments.join(" ")


func _on_query_pieces_cleared() -> void:
    query_label.text = ""
    query_text_segments = []


func _on_EnemyDetector_area_entered(area: Area2D) -> void:
    _velocity = calculate_stomp_velocity(_velocity, stomp_impulse)


func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
    die()


func _physics_process(delta: float) -> void:
    var move_left_or_right_strength = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    move_left_or_right(move_left_or_right_strength)
    if is_on_floor() and Input.is_action_just_pressed("jump"):
        jump(Input.get_action_strength("jump"))
    elif Input.is_action_just_released("jump"):
        interupt_jump()
    move()
    update_head_position()
    update_camera(delta)


func update_camera(delta: float) -> void:
    camera.zoom = lerp(camera.zoom, target_zoom * Vector2.ONE, 1 * delta * zoom_speed)


func move() -> void:
    var snap: Vector2 = Vector2.DOWN * 60.0 if is_on_floor() and _velocity.y >= 0 else Vector2.ZERO
    _velocity = move_and_slide_with_snap(
        _velocity, snap, FLOOR_NORMAL, true
    )


func move_left_or_right(strength: float) -> void:
    _velocity.x = strength * speed.x


func jump(strength) -> void:
    _velocity.y = -speed.y * strength
    jump_audio_player.play()


func interupt_jump() -> void:
    _velocity.y = 0


func calculate_stomp_velocity(linear_velocity: Vector2, stomp_impulse: float) -> Vector2:
    var stomp_jump: = -speed.y if Input.is_action_pressed("jump") else -stomp_impulse
    return Vector2(linear_velocity.x, stomp_jump)


func power_up(power_up_strength: float, power_up_time):
    speed *= power_up_strength
    power_up_timer.wait_time = power_up_time
    power_up_timer.start()


func power_down():
    speed = base_speed


func update_head_position():
    var head_x_offset: float = -1 * clamp(_velocity.x / head_movement_factor, -max_x_head_movement, max_x_head_movement)
    var head_y_offset: float = -1 * clamp(_velocity.y / head_movement_factor, -max_y_head_movement, max_y_head_movement)
    var head_offset_vector: Vector2 = Vector2(head_x_offset, head_y_offset)
    head.position = base_head_position + head_offset_vector

func die() -> void:
    PlayerData.deaths += 1
    PlayerData.reset_level()
    death_audio_player.play()
    visible = false
    yield(death_audio_player, "finished")
    get_tree().reload_current_scene()
    get_tree().paused = false


func _on_PowerUpTimer_timeout() -> void:
    power_down()
