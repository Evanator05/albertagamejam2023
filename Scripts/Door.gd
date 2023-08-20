extends Node3D

@export var listenFor:ButtonManager

var isOpen:bool = false

func _ready():
	listenFor.opened.connect(open)
	listenFor.closed.connect(close)

func open():
	var tween = get_tree().create_tween()
	tween.tween_property($StaticBody3D, "position:y", -4.1, 0.5)
	$AudioStreamPlayer3D.play()
	
func close():
	var tween = get_tree().create_tween()
	tween.tween_property($StaticBody3D, "position:y", 0, 0.5)
	$AudioStreamPlayer3D.play()
