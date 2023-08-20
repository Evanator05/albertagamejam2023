extends StaticBody3D

var used = false
@export var levelId = 0

func _on_detect_area_body_entered(body):
	if used: return
	if (body is Player):
		used = true
		Globals.musicManager.changeSong("res://Audio/Music/Elevator_Music.mp3", "res://Audio/Music/Elevator_Music.mp3")
		Globals.musicManager.changeTrack(0)
		Globals.mapSections.loadSection(levelId)
		# Go to next Level
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:y", position.y+10, 10)
		await tween.finished
		Globals.mapSections.unloadLastSection()
		Globals.musicManager.changeSong("res://Audio/Music/Holding_Cell_Area_-_Calm.mp3", "res://Audio/Music/Holding_Cell_Area_-_Danger.mp3")
		Globals.musicManager.changeTrack(0)
