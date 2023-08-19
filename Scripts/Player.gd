extends CharacterBody3D

var maxSpeed:float = 8

@export var camera:Camera3D

var state:Callable

func _ready():
	state = alive

func _process(delta):
	$Label3D.visible = canInteract()
	state.call()

func alive():
	interact()
	var inputs:Vector2 = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	if inputs != Vector2.ZERO:
		var pos = getMousePos()
		if not pos == null:
			rotation.y = getAngle(pos)
	velocity = Vector3(inputs.x, 0, inputs.y)*maxSpeed
	camera.offset.y = (getRoomSize()/2)+5
	move_and_slide()

func dead():
	pass

func die():
	state = dead

func getAngle(dir):
	var dir2D = Vector2(dir.x, dir.z)
	var angle = -dir2D.angle()
	angle -= PI/2
	return angle

func canInteract():
	for area in $interactionArea.get_overlapping_areas():
		if area.is_in_group("interact"):
			return true
	return false

func interact():
	if Input.is_action_just_pressed("interact"):
		for area in $interactionArea.get_overlapping_areas():
			if area is InteractArea:
				area.interact(self)

func getMousePos():
	var mouse_position = get_viewport().get_mouse_position()
	
	var ray = PhysicsRayQueryParameters3D.new()
	ray.from = camera.project_ray_origin(mouse_position)
	ray.to = ray.from + camera.project_ray_normal(mouse_position) * 2000

	var space_state = get_world_3d().direct_space_state
	var intersection = space_state.intersect_ray(ray)
	
	if not intersection.is_empty():
		var pos = intersection["position"]
		var look_at_me = Vector3(pos.x, global_transform.origin.y, pos.z)
		return look_at_me
	else:
		return null

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
