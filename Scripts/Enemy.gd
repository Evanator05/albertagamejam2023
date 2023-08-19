extends CharacterBody3D

var speed:float = 6

@onready var navAgent:NavigationAgent3D = $NavigationAgent3D
@export var target:Node3D

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

func _ready():
	setTarget(target)
	await get_tree().process_frame #wait until the next frame to start the path
	getNextPoint()

func _process(delta):
	setTarget(patrolPath[currentPoint])
	
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
	
