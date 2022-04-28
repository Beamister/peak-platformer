tool
extends Area2D


onready var anim_player: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
    if Input.is_action_just_pressed("skip_level"):
        teleport()


func _on_body_entered(body: PhysicsBody2D):
    teleport()


func teleport() -> void:
    anim_player.play("fade_out")
    yield(anim_player, "animation_finished")
    print(PlayerData.has_next_level())
    if PlayerData.has_next_level():
        PlayerData.start_new_level()
        PlayerData.load_next_level()
    else:
        var end_screen = load("res://src/UserInterface/EndScreen.tscn")
        get_tree().change_scene_to(end_screen)
