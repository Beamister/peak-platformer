extends KinematicBody2D
class_name Switch
 
signal switch_toggled(switch_id)
 
export var switch_id: int = 0 setget , get_switch_id
 
var open: bool = false
 
onready var animation_player: AnimationPlayer = $AnimationPlayer

 
func get_switch_id() -> int:
	return switch_id


func _ready() -> void:
	# Set default
	open = false


func _on_PlayerDetector_body_entered(body: Node) -> void:
	if body.name == "Player":
		if open == false:
			open = true
			animation_player.play("pressed")
			emit_signal("switch_toggled", switch_id)
