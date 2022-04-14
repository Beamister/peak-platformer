extends Control

onready var message_label: Label = $Label


func _ready() -> void:
    var dir = Directory.new()
    dir.remove("user://savegame.save")
    message_label.text = message_label.text % [PlayerData.score, PlayerData.deaths, PlayerData.total_ghosts_freed]
