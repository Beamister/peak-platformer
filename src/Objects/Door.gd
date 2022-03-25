extends KinematicBody2D
class_name Door

export var door_switch_id: int = 0

onready var animation_player: AnimationPlayer = $AnimationPlayer

var toggle_count: int  = 0

func _ready() -> void:
    find_switch(door_switch_id)


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
    if id == door_switch_id:
        toggle_count -= 1
        if toggle_count == 0:
            animation_player.play("open")
