extends Control

onready var sndPlayer := $snd


func _on_start_pressed():
	sndPlayer.play()

func _on_exit_pressed():
	get_tree().quit()
