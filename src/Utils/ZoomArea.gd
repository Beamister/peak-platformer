extends Area2D

export var zoom_scale: float = 1


func _on_body_entered(body: Node) -> void:
    if body.name == "Player":
        Events.emit_signal("update_camera_zoom", zoom_scale)


func _on_body_exited(body: Node) -> void:
    if body.name == "Player":
        Events.emit_signal("reset_camera")
