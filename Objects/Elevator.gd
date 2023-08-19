extends StaticBody3D

@onready var startingPos = self.global_transform.origin
@export var offset:Vector3 = Vector3()

func _process(delta):
	global_transform.origin = startingPos+offset

func _on_detect_area_body_entered(body):
	if (body is Player):
		# Go to next Level
		body.state = body.frozen
		var tween = get_tree().create_tween()
		tween.tween_property(self, "offset:y", 10, 5)
		#Levels.next_level();
