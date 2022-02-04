extends Node2D


func _on_DataSpawner_spawn_data(data_object, _position, _direction) -> void:
	var new_data_object = data_object.instance()
	add_child(new_data_object)
	new_data_object.spawn(_position, _direction)
