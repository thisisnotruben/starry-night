extends Control

export var dialog_name := ""


func _ready() -> void:
	var dialogue: Node = Dialogic.start(dialog_name)
	add_child(dialogue)
	yield(dialogue, "tree_exited")
	$credits.show()
