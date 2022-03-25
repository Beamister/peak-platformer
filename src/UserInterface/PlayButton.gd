tool
extends Button


export(String, FILE) var next_scene_path: = ""
onready var scene_tree = get_tree()

func _on_button_up() -> void:
    PlayerData.reset_game()
    scene_tree.paused = false
    get_tree().change_scene(next_scene_path)

 
func _get_configuration_warning() -> String:
    return "The property Next Level can't be empty" if next_scene_path == "" else ""
