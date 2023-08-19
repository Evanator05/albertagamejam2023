extends Camera3D

@export var track:Node3D
@export var offset:Vector3 = Vector3()

func _process(delta):
	var pos = track.global_transform.origin + offset
	global_transform.origin = global_transform.origin.lerp(pos, 1-pow(0.002,delta))
