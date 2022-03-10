extends Actor

onready var stomp_area: Area2D = $StompDetector
onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

onready var target: Actor = get_tree().get_nodes_in_group("Players")[0]

onready var upwards_ray: RayCast2D = $UpwardsRay
onready var downwards_ray: RayCast2D = $DownwardsRay
onready var left_ray: RayCast2D = $LeftRay
onready var right_ray: RayCast2D = $RightRay

export var score: int = 100
export var max_speed: float = 300
export var avoidance_strength: float = 300

onready var collision_detectors: Array = $CollisionDetectors.get_children()

func _ready() -> void:
	set_physics_process(false)
	for collision_detector in collision_detectors:
		var _collision_detector: RayCast2D = collision_detector
		_collision_detector.add_exception(self)


func avoid_walls() -> void:
	for collision_detector in collision_detectors:
		var _collision_detector: RayCast2D = collision_detector
		_collision_detector.force_raycast_update()
		var en = _collision_detector.enabled
		var is_col = _collision_detector.is_colliding()
		if _collision_detector.enabled and _collision_detector.is_colliding():
			# get position of collision relative to the entity
			var collision_position = _collision_detector.get_collision_point() - position
			var ray_length: float = (collision_position - _collision_detector.position).length()
			var max_ray_length: float = (_collision_detector.cast_to - _collision_detector.position).length()
			var strength: float = 1 - (ray_length / max_ray_length)
			var avoidance_direction: Vector2 = _collision_detector.cast_to.normalized()
			var collider = _collision_detector.get_collider()
			_velocity -= avoidance_direction * strength * avoidance_strength


func _physics_process(delta: float) -> void:
	var target_position: Vector2 = target.position
	var target_direction: Vector2 = (target_position - position).normalized()
	_velocity.x += target_direction.x * speed.x
	_velocity.y += target_direction.y * speed.y
	avoid_walls()
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

