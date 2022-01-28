extends Control

onready var message_label: Label = $Label


func _ready() -> void:
	message_label.text = message_label.text % [PlayerData.score, PlayerData.deaths]
