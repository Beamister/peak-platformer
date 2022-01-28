extends KinematicBody2D
class_name Door

export var door_switch_id: int = 0

onready var animation_player: AnimationPlayer = $AnimationPlayer

var switch_count: int  = 0

func _ready() -> void:
	find_switch(door_switch_id)


func find_switch(id: int) -> void:
	var err: int = 0
	var switches = get_tree().get_nodes_in_group("Switches")
	
	for switch in switches:
		if switch.switch_id == id:
			if switch.is_connected("switch_toggled", self, "trigger_switch_toggled") == false:
				err = switch.connect("switch_toggled", self, "trigger_switch_toggled")
				switch_count += 1


func trigger_switch_toggled(id: int) -> void:
	# Make sure it was the switch that is associated with this door
	if id == door_switch_id:
		switch_count -= 1
		if switch_count == 0:
			animation_player.play("open")
