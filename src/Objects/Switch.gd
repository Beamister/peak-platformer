extends KinematicBody2D
class_name Switch
 
var open: bool = false
 
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var toggle_controller: Node = $ToggleController
export var circuit_id: int = 0


func _ready() -> void:
	# Set default
	open = false
	toggle_controller.circuit_id = circuit_id


func _on_PlayerDetector_body_entered(body: Node) -> void:
	if body.name == "Player":
		if open == false:
			open = true
			toggle_controller.set_state(true)
			animation_player.play("pressed")
