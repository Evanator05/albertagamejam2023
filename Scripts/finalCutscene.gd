extends Area3D

func _on_body_entered(body):
	if body is Player:
		body.state = body.frozen
		var tween = get_tree().create_tween()
		tween.tween_property($ColorRect, "color:a", 1, 5)
		await tween.finished
		#change to ending screen
		
