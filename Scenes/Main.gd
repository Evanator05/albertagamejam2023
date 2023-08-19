extends Node3D

var ray_origin = Vector3()
var ray_target = Vector3()


func _physics_process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	
	var ray = PhysicsRayQueryParameters3D.new()
	ray.from = $Camera3D.project_ray_origin(mouse_position)
	ray.to = ray.from + $Camera3D.project_ray_normal(mouse_position) * 2000

	var space_state = get_world_3d().direct_space_state
	var intersection = space_state.intersect_ray(ray)
	
	if not intersection.is_empty():
		var pos = intersection["position"]
		var look_at_me = Vector3(pos.x, $Player.position.y, pos.z)
		$Player.look_at(look_at_me, Vector3.UP)

# Called when the node enters the scene tree for the first time.
#func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
