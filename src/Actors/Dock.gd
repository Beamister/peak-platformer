extends Actor

func _physics_process(delta: float) -> void:
    _velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
    if is_on_floor():
        _velocity.x = 0
