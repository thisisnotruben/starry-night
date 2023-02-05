extends CenterContainer


func _on_return_pressed():
	get_tree().change_scene("res://src/ui/start/start.tscn")

func _on_exit_pressed():
	get_tree().quit()
