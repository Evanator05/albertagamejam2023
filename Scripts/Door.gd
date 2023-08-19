extends StaticBody3D

@export var listenFor:ButtonManager

func _ready():
	listenFor.opened.connect(open)
	listenFor.closed.connect(close)

func open():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_transform:origin:y", global_transform.origin.y-4, 0.5)
	
func close():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_transform:origin:y", global_transform.origin.y+4, 0.5)
