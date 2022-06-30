extends Actor

export var button_id: int = 0
export var rotation_change: float = 90
export var rotation_speed: float = 100

onready var desired_rotation: float = rotation_degrees


func _ready() -> void:
    Events.connect("button_pressed", self, "_on_button_pressed")


func _process(delta: float) -> void:
    if rotation_degrees != desired_rotation:
        var actual_rotation: float = fmod(rotation_degrees, 360)
        var rotational_difference = desired_rotation - rotation_degrees
        if abs(rotational_difference) < rotation_speed:
            _angular_velocity = rotational_difference
        else:
            if rotational_difference > 0:
                _angular_velocity = rotation_speed
            else:
                _angular_velocity = -rotation_speed


func _on_button_pressed(pressed_button_id) -> void:
    var actual_rotation: float = fmod(rotation_degrees, 360)
    if pressed_button_id == button_id and rotation_degrees >= desired_rotation:
        desired_rotation += rotation_change
