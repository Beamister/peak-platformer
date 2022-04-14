extends StaticBody2D

onready var animation_player = $AnimationPlayer


func _on_PlayerDetector_body_entered(body: Node) -> void:
    PlayerData.free_ghost()
    animation_player.play("freed")
