extends Control


func _on_start_pressed():
	$snd.play()
	$center.hide()
	add_child(Dialogic.start("intro"))
	# TODO: play sound when dialogue ends
	# 	- then fade out to game scene

func _on_about_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
