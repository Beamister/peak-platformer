extends StaticBody2D

onready var animation_player = $AnimationPlayer


func _ready() -> void:
	PlayerData.total_ghosts += 1


func _on_PlayerDetector_body_entered(body: Node) -> void:
	PlayerData.ghosts_freed += 1
	animation_player.play("freed")
