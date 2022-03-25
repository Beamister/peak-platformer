extends Actor


onready var stomp_area: Area2D = $StompDetector
onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

export var score: = 100


func _ready() -> void:
    set_physics_process(false)
    _velocity.x = -speed.x


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
    if body.global_position.y > stomp_area.global_position.y or body.name != 'Player':
        return
    die()


func _physics_process(delta: float) -> void:
    _velocity.x *= -1 if is_on_wall() else 1
    _velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func die():
    PlayerData.score += score
    audio_player.play()
    visible = false
    stomp_area.monitoring = false
    stomp_area.monitorable = false
    collision_layer = 0
    collision_mask = 0
    yield(audio_player, "finished")
    queue_free()

