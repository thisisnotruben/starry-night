extends Control


func _on_start_pressed() -> void:
	$snd.play()
	$main.hide()
	add_child(Dialogic.start("intro"))

func _on_about_pressed() -> void:
	$snd.play()
	$about.show()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_about_visibility_changed() -> void:
	$main.visible = !$about.visible
