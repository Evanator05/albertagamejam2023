extends Node3D

signal opened()

func _ready():
	for child in get_children():
		if child is PressButton:
			child.stateUpdated.connect(stateUpdated)

func stateUpdated(state):
	for child in get_children():
		if not child.isPressed: 
			
			return false

	emit_signal("opened")
	return true
