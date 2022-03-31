extends Button

onready var http_request: HTTPRequest = $HTTPRequest

func _ready() -> void:
    var os_name = OS.get_name()
    if os_name != "HTML5":
        queue_free()

func _on_button_up() -> void:
    var error = http_request.request("https://peak-platformer-test.s3.eu-west-2.amazonaws.com/app/peak-platformer-debug.apk")
    if error != OK:
        push_error("An error occurred in the HTTP request.")


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
    if response_code == 200:
        JavaScript.download_buffer(body, "peak-platformer.apk")
