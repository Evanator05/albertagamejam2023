extends CharacterBody3D

var speed:float = 6

@onready var navAgent:NavigationAgent3D = $NavigationAgent3D
@export var target:Node3D

var nextPoint:Vector3 = Vector3()

@export var patrolPath:Array[Node3D]

var state = PATROL

enum {PATROL, ALERT}

func _ready():
	setTarget(target)
	await get_tree().process_frame #wait until the next frame to start the path
	getNextPoint()

func _process(delta):
	var moveDir:Vector3 = nextPoint-global_transform.origin
	if moveDir.length() < 1: #if the distence to the current point is less than 1 get the next point
		if navAgent.is_target_reached():
			pass
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
