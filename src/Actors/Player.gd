extends Actor


export var stomp_impulse: = 600.0

onready var jump_audio_player: AudioStreamPlayer = $JumpAudioStreamPlayer
onready var death_audio_player: AudioStreamPlayer = $DeathAudioStreamPlayer

onready var base_speed: Vector2 = speed
var power_up_time_remaining: float = 0


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
	handle_power_ups(delta)


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
	print(_velocity.y)


func interupt_jump() -> void:
	_velocity.y = 0


func handle_power_ups(delta: float) -> void:
	if power_up_time_remaining > 0:
		power_up_time_remaining -= delta
	if power_up_time_remaining < 0:
		power_up_time_remaining = 0
		power_down()


func calculate_stomp_velocity(linear_velocity: Vector2, stomp_impulse: float) -> Vector2:
	var stomp_jump: = -speed.y if Input.is_action_pressed("jump") else -stomp_impulse
	return Vector2(linear_velocity.x, stomp_jump)


func power_up(power_up_strength: float, power_up_time):
	speed *= power_up_strength
	power_up_time_remaining = power_up_time
	print("Powering up")


func power_down():
	speed = base_speed
	print("Powering down")


func die() -> void:
	PlayerData.deaths += 1
	PlayerData.reset_level()
	death_audio_player.play()
	visible = false
	yield(death_audio_player, "finished")
	get_tree().reload_current_scene()
	get_tree().paused = false
