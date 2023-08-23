extends Control

## func _ready():
##	var audioTween = get_tree().create_tween()
##	audioTween.tween_property($TitleMusic, "volume_db", 5, 5)

func _on_texture_button_pressed():
	# Show exposition
	$Intro.show()


func _on_button_pressed():
##	var audioTween = get_tree().create_tween()
##	audioTween.tween_property($TitleMusic, "volume_db", -15.0, 5)
	$BlackRect.show()
	var toBlackTween = get_tree().create_tween()
	toBlackTween.tween_property($BlackRect, "color:a", 1.0, 5)
	await toBlackTween.finished
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
