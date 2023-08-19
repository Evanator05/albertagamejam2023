class_name PressButton extends Node3D

signal stateUpdated(state)

@export var timerLength:float = 0 #set to 0 if its not a timed button
var isPressed:bool = false

func _ready():
	$interactArea.interacted.connect(interacted)

func interacted(interacter):
	isPressed = true
	emit_signal("stateUpdated", isPressed)
	if timerLength == 0: return
	get_tree().create_timer(timerLength).timeout.connect(timerEnded)

func timerEnded():
	isPressed = false
	emit_signal("stateUpdated", isPressed)
