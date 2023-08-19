extends StaticBody3D

@export var listenFor:ButtonManager

var isOpen:bool = false

@onready var startingPos:Vector3 = global_transform.origin
@export var offset:Vector3


func _ready():
	listenFor.opened.connect(open)
	listenFor.closed.connect(close)

func _process(delta):
	global_transform.origin = startingPos+offset

func open():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "offset:y", -4, 0.5)
	
func close():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "offset:y", 0, 0.5)
