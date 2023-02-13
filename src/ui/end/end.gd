extends Control

export var dialog_name := ""


func _ready() -> void:
	var dialogue: Node = Dialogic.start(dialog_name)
	add_child(dialogue)
	yield(dialogue, "tree_exited")
	$credits.show()

func _on_credits_draw() -> void:
	$credits/panel/margin/main/return.grab_focus()
