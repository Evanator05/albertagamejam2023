extends Control

func _ready():
	var toWhiteTween = get_tree().create_tween()
	toWhiteTween.tween_property($WhiteRect, "color:a", 0.0, 5)
	await toWhiteTween.finished
	$WhiteRect.hide()
	

func _on_button_pressed():
	$BlackRect.show()
	var toBlackTween = get_tree().create_tween()
	toBlackTween.tween_property($BlackRect, "color:a", 1.0, 5)
	await get_tree().create_timer(1.5).timeout#		(kind of) lines the music up with $Credits.show()
	$CreditsEventEmitter2D.play()#					starts playing the music (with tween)
	await toBlackTween.finished
	$Button.hide()
	$Credits.show()
	$TitleButton.show()


func _on_title_button_pressed():
	$CreditsEventEmitter2D.stop()#				starts fading out
	await get_tree().create_timer(2).timeout#	AHDSR Release set to 2s in FMOD
	get_tree().change_scene_to_file("res://Scenes/Ui/Title.tscn")
