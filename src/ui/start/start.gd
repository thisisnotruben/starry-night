extends Control


func _on_start_pressed():
	$snd.play()
	$main.hide()
	var dialogue: Node = Dialogic.start("intro")
	add_child(dialogue)
	dialogue.connect("tree_exited", self, "_on_dialogue_finsihed")

func _on_about_pressed():
	$snd.play()
	$about.show()

func _on_exit_pressed():
	get_tree().quit()

func _on_dialogue_finsihed() -> void:
	get_tree().change_scene("res://src/map/scenes/scene_1.tscn")

func _on_about_visibility_changed():
	$main.visible = !$about.visible

