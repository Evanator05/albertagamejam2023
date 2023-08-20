class_name ButtonManager extends Node3D

signal opened()
signal closed()

func _ready():
	for child in get_children():
		if child is PressButton:
			child.stateUpdated.connect(stateUpdated)

func stateUpdated(_state):
	for child in get_children():
		if not child.isPressed:
			emit_signal("closed")
			return false
	emit_signal("opened")
	return true
