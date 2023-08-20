extends StaticBody3D

var used = false
@export var levelId = 0

func _on_detect_area_body_entered(body):
	if used: return
	if (body is Player):
		used = true
		Globals.mapSections.loadSection(levelId)
		# Go to next Level
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:y", position.y+10, 5)
		await tween.finished
		Globals.mapSections.unloadLastSection()
		
