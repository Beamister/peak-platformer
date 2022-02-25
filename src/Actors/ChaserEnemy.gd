extends Actor

onready var stomp_area: Area2D = $StompDetector
onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

onready var target: Actor = get_tree().get_nodes_in_group("Players")[0]

export var score: int = 100
export var max_speed: float = 300

func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	var target_position: Vector2 = target.position
	var target_direction: Vector2 = (target_position - position).normalized()
	_velocity.x += target_direction.x * speed.x
	_velocity.y += target_direction.y * speed.y
	if _velocity.length() > max_speed:
		_velocity = _velocity.normalized() * max_speed
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > stomp_area.global_position.y or body.name != 'Player':
		return
	die()


func die():
	PlayerData.score += score
	audio_player.play()
	visible = false
	collision_layer = 0
	collision_mask = 0
	yield(audio_player, "finished")
	queue_free()

