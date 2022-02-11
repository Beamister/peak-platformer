tool
extends Area2D


onready var anim_player: AnimationPlayer = $AnimationPlayer

export var next_scene: PackedScene


func _process(delta: float) -> void:
	if Input.is_action_pressed("skip_level"):
		teleport()

func _on_body_entered(body: PhysicsBody2D):
	teleport()


func _get_configuration_warning() -> String:
	return "The property Next Level can't be empty" if not next_scene else ""


func teleport() -> void:
	anim_player.play("fade_out")
	yield(anim_player, "animation_finished")
	PlayerData.start_new_level()
	get_tree().paused = false
	get_tree().change_scene_to(next_scene)
