extends Node

@onready var tracks = get_children()
var currentTrackId:int = 0

func _ready():
	Globals.musicManager = self
	changeSong("res://Audio/Music/Holding_Cell_Area_-_Calm.mp3", "res://Audio/Music/Holding_Cell_Area_-_Danger.mp3")
	changeTrack(0)

func changeTrack(trackId):
	var t1 = get_tree().create_tween()
	t1.tween_property(tracks[currentTrackId], "volume_db", -80, 1)
	var t2 = get_tree().create_tween()
	t2.tween_property(tracks[trackId], "volume_db", 0, 1)
	currentTrackId = trackId

func changeSong(mainTrack:String, dangerTrack:String):
	$main.stream = load(mainTrack)
	$danger.stream = load(dangerTrack)
	$main.play()
	$danger.play()

