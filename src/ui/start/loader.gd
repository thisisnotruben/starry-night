extends Node
class_name GameLoader

var thread: Thread = Thread.new()

export(NodePath) var progress_bar_path = ""
onready var progress_bar: Range = get_node(progress_bar_path)

signal done_loading(packed_scene)


func start() -> void:
	thread.start(self, "_run")

func _run() -> void:
	var scene_loader = ResourceLoader.load_interactive("res://src/map/scenes/scene_1.tscn")

	var poll = scene_loader.poll()
	while poll == OK:
		progress_bar.value = \
			100.0 * scene_loader.get_stage() / scene_loader.get_stage_count()
		poll = scene_loader.poll()

	if poll == ERR_FILE_EOF:
		emit_signal("done_loading", scene_loader.get_resource())

func _exit_tree() -> void:
	thread.wait_to_finish()
