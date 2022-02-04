extends Area2D

var velocity: Vector2 = Vector2.ZERO
var speed: float = 3


func _physics_process(delta: float) -> void:
	position += velocity


func spawn(_position: Vector2, _direction: Vector2) -> void:
	velocity = _direction * speed
	rotation = _direction.angle()
	position = _position


func _on_Data_body_entered(body: Node) -> void:
	if body.has_method('consume_data'):
		body.consume_data()
	disappear()


func disappear() -> void:
	queue_free()


func _on_Data_area_entered(area: Area2D) -> void:
	disappear()
