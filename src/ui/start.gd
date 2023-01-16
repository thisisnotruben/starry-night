extends Control


func _on_start_pressed():
	$snd.play()
	$center.hide()
	add_child(Dialogic.start("intro"))

func _on_exit_pressed():
	get_tree().quit()
