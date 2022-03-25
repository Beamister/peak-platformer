extends Node2D


func spawn_entity(entity_object, _position, _direction, metadata={}) -> void:
    var new_entity = entity_object.instance()
    add_child(new_entity)
    new_entity.spawn(_position, _direction, metadata)
