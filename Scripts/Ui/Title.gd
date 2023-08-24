extends Control


func _on_texture_button_pressed():
	# Show exposition
	$Intro.show()


func _on_button_pressed():
	$BlackRect.show()
	var toBlackTween = get_tree().create_tween()
	toBlackTween.tween_property($BlackRect, "color:a", 1.0, 5)
	$TitleEventEmitter2D.stop()
	await toBlackTween.finished
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
