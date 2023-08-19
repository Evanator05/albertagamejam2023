class_name InteractArea extends Area3D

signal interacted(interacter)

func interact(interacter):
	emit_signal("interacted", interacter)
