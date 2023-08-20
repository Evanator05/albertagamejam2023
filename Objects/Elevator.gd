extends StaticBody3D

@onready var startingPos = self.global_transform.origin
@onready var level = get_parent()
@export var offset:Vector3 = Vector3()

func _process(delta):
	global_transform.origin = startingPos+offset

func _on_detect_area_body_entered(body):
	if (body is Player):
		# Go to next Level
		body.state = body.frozen
		#var tween = get_tree().create_tween()
		#print(level)
#		tween.tween_property(level, "glo", 10, 5)
		Levels.nextLevel();
