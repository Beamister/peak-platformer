extends Area2D


func _on_body_entered(body: Node) -> void:
    PlayerData.query_pieces += 1
    queue_free()
