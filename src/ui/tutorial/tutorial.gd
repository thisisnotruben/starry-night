extends Control


func _ready() -> void:
	get_tree().paused = true
	$main/panel/margin/vBox/continue.grab_focus()

func _on_continue_pressed() -> void:
	get_tree().paused = false
	queue_free()
