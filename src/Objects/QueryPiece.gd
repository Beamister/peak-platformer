extends Area2D


export var query_text: String = ""
export var query_text_index: int = 0

onready var label: Label = $Label


func _ready() -> void:
    label.text = query_text


func _on_body_entered(body: Node) -> void:
    Events.emit_signal("query_piece_acquired", query_text, query_text_index)
    queue_free()
