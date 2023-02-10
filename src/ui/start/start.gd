extends Control

onready var progress_bar: Range = $progress/panel/margin/vBox/progress_bar
onready var _root := get_tree().root

var scene_loader: ResourceInteractiveLoader = null
var difficulty := ""

func _ready() -> void:
	set_process(false)

func _on_start_pressed() -> void:
	$snd.play()
	$main/panel/margin/main.hide()
	$main/panel/margin/difficulty.show()

func _on_difficulty_pressed(_difficulty: String) -> void:
	difficulty = _difficulty
	$snd.play()
	$main.hide()
	var dialog: Node = Dialogic.start("intro")
	dialog.connect("tree_exited", self, "_on_dialogue_ended")
	add_child(dialog)

func _on_dialogue_ended() -> void:
	scene_loader = ResourceLoader.load_interactive("res://src/map/scenes/scene_1.tscn")
	$progress.show()
	set_process(true)

func _process(delta: float) -> void:
	match scene_loader.poll():
		OK:
			progress_bar.value = \
				100.0 * scene_loader.get_stage() / scene_loader.get_stage_count()
		ERR_FILE_EOF:
			set_process(false)
			connect("tree_exited", self, "set_scene")
			queue_free()

func set_scene() -> void:
	_root.add_child(scene_loader.get_resource().instance())

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
