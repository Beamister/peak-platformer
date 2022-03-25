extends Node2D
tool

export var power_up_strength: float
export var power_up_length: float

onready var animation_palyer = $AnimationPlayer

func _on_body_entered(body: Node) -> void:
    if body.name == "Player":
        body.power_up(power_up_strength, power_up_length)
        animation_palyer.play("picked")


func _get_configuration_warning():
    if power_up_length == 0 or power_up_strength == 0:
        return 'Power up not set correctly'
    return ''
