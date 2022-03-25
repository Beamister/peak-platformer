extends Control


onready var scene_tree = get_tree()
onready var pause_overlay: ColorRect = $PauseOverlay
onready var score_label: Label = $Score
onready var title_label: Label = $PauseOverlay/PauseTitle
onready var main_screen_button: Button = $PauseOverlay/PauseMenu/MainMenuButton
onready var animation_player: AnimationPlayer = $AnimationPlayer

var paused: = false setget set_paused


func _ready() -> void:
    PlayerData.connect("score_updated", self, "update_interface")
    PlayerData.connect("player_died", self, "_on_Player_died")
    PlayerData.connect("reset", self, "_on_Player_reset")
    update_interface()


func _on_Player_died() -> void:
    animation_player.play("death")


func _on_Player_reset() -> void:
    self.paused = false


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause"):
        self.paused = not paused
        scene_tree.set_input_as_handled() 


func update_interface() -> void:
    score_label.text = "Score: %s" % PlayerData.score


func set_paused(value: bool) -> void:
    paused = value
    scene_tree.paused = value 
    pause_overlay.visible = value
