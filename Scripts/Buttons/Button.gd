class_name PressButton extends Node3D

signal stateUpdated(state)

@export var timerLength:float = 0 #set to 0 if its not a timed button
var isPressed:bool = false

func _ready():
	setColor(Color(0,1,0))
	$interactArea.interacted.connect(interacted)

func interacted(interacter):
	isPressed = true
	setColor(Color(1,0,0))
	emit_signal("stateUpdated", isPressed)
	if timerLength == 0: return
	get_tree().create_timer(timerLength).timeout.connect(timerEnded)

func timerEnded():
	isPressed = false
	setColor(Color(0,1,0))
	emit_signal("stateUpdated", isPressed)

func setColor(color:Color):
	var mat:StandardMaterial3D = $MeshInstance3D.mesh.material
	mat.albedo_color = color
