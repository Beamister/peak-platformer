extends StaticBody2D

export var button_id: int = 0


func _on_PlayerDetector_body_entered(body: Node) -> void:
    if body.name == "Player":
        Events.emit_signal("button_pressed", button_id)
