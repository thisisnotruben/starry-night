extends Control


func _ready() -> void:
	var popup: ConfirmationDialog = $"%confirm_start_menu"
	popup.dialog_text = "Go to Start Menu?!"
	popup.get_ok().text = "Go"
	popup.get_cancel().text = "Stay"
	popup.get_cancel().connect("pressed", self, "_on_confirm_start_menu_cancelled")

func _input(event) -> void:
	if event.is_action_pressed("pause"):
		$snd.play()
		if $about.visible:
			$about.hide()
		else:
			visible = !visible

func _on_resume_game_pressed():
	$snd.play()
	hide()

func _on_start_menu_pressed():
	$snd.play()
	$"%confirm_start_menu".popup_centered()

func _on_about_pressed():
	$snd.play()
	$about.show()

func _on_exit_pressed():
	get_tree().quit()

func _on_game_visibility_changed():
	get_tree().paused = visible

func _on_about_visibility_changed():
	$main.visible = !$about.visible

func _on_confirm_start_menu_confirmed():
	get_tree().paused = false
	get_tree().change_scene("res://src/ui/start/start.tscn")

func _on_confirm_start_menu_cancelled():
	$snd.play()
	$"%confirm_start_menu".hide()
