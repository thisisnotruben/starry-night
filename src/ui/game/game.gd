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

func _on_resume_game_pressed() -> void:
	$snd.play()
	hide()

func _on_start_menu_pressed() -> void:
	$snd.play()
	$main.hide()
	$"%confirm_start_menu".popup_centered()

func _on_about_pressed() -> void:
	$snd.play()
	$about.show()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_game_visibility_changed() -> void:
	get_tree().paused = visible

func _on_about_visibility_changed() -> void:
	$main.visible = !$about.visible

func _on_confirm_start_menu_confirmed() -> void:
	get_tree().paused = false
	get_tree().change_scene("res://src/ui/start/start.tscn")

func _on_confirm_start_menu_cancelled() -> void:
	$snd.play()
	$"%confirm_start_menu".hide()
	$main.show()
