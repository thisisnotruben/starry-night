extends CenterContainer


func _on_github_pressed():
	$snd.play()
	OS.shell_open("https://github.com/thisisnotruben/starry-night")

func _on_return_pressed() -> void:
	get_tree().change_scene("res://src/ui/start/start.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_credits_draw():
	var back_button = get_node_or_null("panel/margin/main/back")
	if not $panel/margin/main/exit.visible and back_button != null:
		$panel/margin/main/github.focus_neighbour_top = back_button.get_path()
		back_button.focus_neighbour_bottom = $panel/margin/main/github.get_path()
	else:
		$panel/margin/main/return.grab_focus()
