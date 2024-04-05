extends Control

onready var _root := get_tree().root
var difficulty := ""
export var game_scene: PackedScene = null


func _on_start_pressed() -> void:
	$snd.play()
	$main/panel/margin/main.hide()
	$main/panel/margin/difficulty.show()
	$main/panel/margin/difficulty/easy.grab_focus()

func _on_difficulty_pressed(_difficulty: String) -> void:
	difficulty = _difficulty
	$snd.play()
	$main.hide()
	var dialog: Node = Dialogic.start("intro")
	add_child(dialog)
	yield(dialog, "tree_exited")
	get_tree().change_scene_to(game_scene)

func _on_difficulty_back_pressed() -> void:
	$snd.play()
	$main/panel/margin/difficulty.hide()
	$main/panel/margin/main.show()

func _on_license_pressed() -> void:
	$snd.play()
	$about.show()

func _on_credits_pressed() -> void:
	$snd.play()
	$main.hide()
	$credits.show()

func _on_credits_back_pressed() -> void:
	$snd.play()
	$credits.hide()
	$main.show()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_about_visibility_changed() -> void:
	$main.visible = !$about.visible

func _on_main_draw() -> void:
	$main/panel/margin/main/start.grab_focus()

func _on_credits_draw() -> void:
	$credits/panel/margin/main/back.grab_focus()
