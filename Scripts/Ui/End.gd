extends Control

func _ready():
	var toWhiteTween = get_tree().create_tween()
	toWhiteTween.tween_property($WhiteRect, "color:a", 0.0, 5)
	await toWhiteTween.finished
	$WhiteRect.hide()

func _on_button_pressed():
	#var audioTween = get_tree().create_tween()
	#audioTween.tween_property($EndMusic, "volume_db", -15.0, 5)
	$BlackRect.show()
	var toBlackTween = get_tree().create_tween()
	toBlackTween.tween_property($BlackRect, "color:a", 1.0, 5)
	await toBlackTween.finished
	$Button.hide()
	$Credits.show()
	$TitleButton.show()


func _on_title_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Ui/Title.tscn")
