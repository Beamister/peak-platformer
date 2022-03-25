extends TouchScreenButton

func _ready() -> void:
    var screen_dpi = OS.get_screen_dpi()
    var scale_by = 1
    if screen_dpi > 256:
        scale_by = 2
    scale.x *= scale_by
    scale.y *= scale_by
