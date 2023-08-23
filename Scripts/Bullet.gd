extends Node3D

const SPEED = 15.0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var particles = $GPUParticles3D

func _process(delta):
	ray.force_raycast_update()
	if ray.is_colliding():
		global_transform.origin = ray.get_collision_point()
		particles.emitting = true
		mesh.visible = false
		ray.enabled = false
		if ray.get_collider().is_in_group("enemy"):
			ray.get_collider().hit()
		await get_tree().create_timer(1.0).timeout
		queue_free()
	position += transform.basis * Vector3(0, 0, -SPEED) * delta

func _on_timer_timeout():
	queue_free()
