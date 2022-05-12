extends Actor

export var starting_x_velocity: float = 0
export var starting_y_velocity: float = 0
export var bounce_velocity_modifier: float = 1.01
export var rotation_speed: float = 1

onready var timer: Timer = $VisibilityTimer


func _ready() -> void:
    visible = false
    set_physics_process(false)

func _on_screen_entered() -> void:
    timer.start()


func _physics_process(delta: float) -> void:
    var collision = move_and_collide(_velocity * delta)
    if collision:
        _velocity = _velocity.bounce(collision.normal) * bounce_velocity_modifier
        if _velocity.x > 0:
            _angular_velocity = rotation_speed
        else:
            _angular_velocity = -rotation_speed


func _on_VisibilityTimer_timeout() -> void:
    visible = true
    _velocity.x = starting_x_velocity
    _velocity.y = starting_y_velocity
    set_physics_process(true)
