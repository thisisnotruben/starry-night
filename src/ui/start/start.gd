extends Control

onready var _root := get_tree().root
var difficulty := ""


func _on_start_pressed() -> void:
	$snd.play()
	$main/panel/margin/main.hide()
	$main/panel/margin/difficulty.show()

func _on_difficulty_pressed(_difficulty: String) -> void:
	difficulty = _difficulty
	$snd.play()
	$main.hide()
	var dialog: Node = Dialogic.start("intro")
	add_child(dialog)
	yield(dialog, "tree_exited")
	$loader.start()
	$progress.show()

func _on_loader_done_loading(packed_scene: PackedScene):
	queue_free()
	yield(self, "tree_exited")
	var scene = packed_scene.instance()
	scene.difficulty = difficulty
	_root.add_child(scene)

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
