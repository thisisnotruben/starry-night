extends Control


func _on_back_pressed() -> void:
	$snd.play()
	hide()

func _on_license_redirect_pressed():
	$snd.play()
	OS.shell_open("https://github.com/thisisnotruben/starry-night/blob/main/LICENCE.md")
