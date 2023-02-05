extends Control

export var dialog_name := ""


func _ready() -> void:
	var dialogue: Node = Dialogic.start(dialog_name)
	add_child(dialogue)
	dialogue.connect("tree_exited", self, "_on_dialogue_finsihed")

func _on_dialogue_finsihed() -> void:
	$credits.show()
