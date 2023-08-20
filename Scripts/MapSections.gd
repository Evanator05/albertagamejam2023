extends Node3D

var sections = [
	"res://Scenes/Level 0 intro.tscn",
	"res://Scenes/Level 1.tscn",
	"res://Scenes/Level 2.tscn",
	"res://Scenes/Level 3.tscn",
	"res://Scenes/Level 4.tscn",
	"res://Scenes/Level Hard.tscn"
]

var currentMap
var respawnPoint:Vector3
var firstMap = true

func _ready():
	Globals.mapSections = self
	loadSection(0)

func loadSection(index:int):
	var mapScene:Resource = load(sections[index])
	var mapInst = mapScene.instantiate()
	add_child(mapInst)
	var diff = Vector3()
	if not firstMap:
		diff = currentMap.endPos.global_transform.origin - mapInst.startPos.global_transform.origin
	mapInst.global_transform.origin = diff
	respawnPoint = mapInst.startPos.global_transform.origin + Vector3(0, 1, 0)
	currentMap = mapInst
	firstMap = false

func unloadLastSection():
	get_children()[0].queue_free()
