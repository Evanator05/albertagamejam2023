extends CharacterBody3D

var maxSpeed:float = 8

@export var camera:Camera3D

func _process(delta):
	var inputs:Vector2 = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	if inputs != Vector2.ZERO:
		rotation.y = getAngle(Vector3(inputs.x,0,inputs.y))
	velocity = Vector3(inputs.x, 0, inputs.y)*maxSpeed
	camera.offset.y = getRoomSize()
	move_and_slide()

func getAngle(dir):
	var dir2D = Vector2(dir.x, dir.z)
	var angle = -dir2D.angle()
	angle -= PI/2
	return angle

func getRoomSize():
	$Raycasts.global_transform.origin = global_transform.origin
	var size = 0
	for cast in $Raycasts.get_children():
		if cast is RayCast3D:
			if not cast.is_colliding(): 
				size += 10
				continue
			size += global_transform.origin.distance_to(cast.get_collision_point())
	size /= $Raycasts.get_child_count()
	return size
