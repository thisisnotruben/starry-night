extends Control


func _on_back_pressed() -> void:
	$snd.play()
	hide()
