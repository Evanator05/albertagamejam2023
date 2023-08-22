extends CharacterBody3D

var speed:float = 6

@onready var navAgent:NavigationAgent3D = $NavigationAgent3D
@export var target:Node3D
var chaseTarget = null

var nextPoint:Vector3 = Vector3()

@export var patrolPath:Array[Node3D]
var currentPoint:int = 0 :
	set(value):
		if value > patrolPath.size()-1:
			value = 0
		if value < 0:
			value = patrolPath.size()-1
		currentPoint = value
		
var state = PATROL
enum {PATROL, ALERT}

@export var damage = 1
@export var health = 1
signal body_part_hit(dam)

func _ready():
	Globals.refreshLevel.connect(func(): state = PATROL)
	
	setTarget(target)
	await get_tree().process_frame #wait until the next frame to start the path
	getNextPoint()

func _process(delta):
	match state:
		PATROL:
			setTarget(patrolPath[currentPoint])
		ALERT:
			setTarget(chaseTarget)
	
	var moveDir:Vector3 = nextPoint-global_transform.origin
	rotation.y = lerp_angle(rotation.y, getAngle(moveDir), 1-pow(0.002, delta))
	if moveDir.length() < 1: #if the distence to the current point is less than 1 get the next point
		if navAgent.distance_to_target() < 1:
			currentPoint += 1
		getNextPoint()
	moveDir = moveDir.normalized()
	velocity = moveDir*speed
	move_and_slide()

func setTarget(t:Node3D):
	target = t
	var targetPos:Vector3 = target.global_transform.origin
	navAgent.set_target_position(targetPos)

func getNextPoint():
	nextPoint = navAgent.get_next_path_position()

func getAngle(dir):
	var dir2D = Vector2(dir.x, dir.z)
	var angle = -dir2D.angle()
	angle -= PI/2
	return angle

func _on_spot_area_body_entered(body):
	# Player enters SpotArea cone
	if (body.get_name() == "Player"):
		# Only "Spot" them if they're in line of sight
		var ray = PhysicsRayQueryParameters3D.new()
		ray.from = self.global_transform.origin
		ray.to = body.global_transform.origin
		ray.set_exclude([self.get_rid()])
		var space_state = get_world_3d().direct_space_state
		var intersection = space_state.intersect_ray(ray)
		if not intersection.is_empty():
			var col = intersection["collider"]
			if col == body:
				state = ALERT
				Globals.activeGuards += 1
				chaseTarget = body

func _on_die_area_body_entered(body):
	if (body is Player and state == ALERT):
		body.die()
		Globals.activeGuards = 0
		Globals.emit_signal("refreshLevel")

func hit():
	emit_signal("body_part_hit", damage)

func _on_body_part_hit(dam):
	health -= dam
	#var moveDir:Vector3 = nextPoint-global_transform.origin
	if health <= 0:
		speed = 0
		Globals.activeGuards -= 1
		$die/CollisionShape3D.disabled = true
		get_tree().create_timer(5.0).timeout.connect(func(): 
			speed = 6
			$die/CollisionShape3D.disabled = false
			state = PATROL
			)
		move_and_slide()
		
