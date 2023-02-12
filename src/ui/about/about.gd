extends Control


func _on_back_pressed() -> void:
	$snd.play()
	hide()

func _on_license_redirect_pressed() -> void:
	$snd.play()
	OS.shell_open("https://github.com/thisisnotruben/starry-night/blob/main/LICENCE.md")

func _on_about_draw() -> void:
	$center/panel/margin/main/back.grab_focus()
