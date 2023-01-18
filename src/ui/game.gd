extends Control


func _ready():
	pass # Replace with function body.

func _on_start_menu_pressed():
	# TODO: play sound first then transition
	get_tree().change_scene("res://src/ui/start.tscn")

func _on_exit_pressed():
	get_tree().quit()
