extends CenterContainer


func _on_github_pressed():
	$snd.play()
	OS.shell_open("https://github.com/thisisnotruben/starry-night")

func _on_return_pressed() -> void:
	get_tree().change_scene("res://src/ui/start/start.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
