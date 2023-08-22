extends Node

signal refreshLevel

var mapSections
var musicManager

var activeGuards:int = 0 :
	set(value):
		activeGuards += 1
		musicManager.changeTrack(0 if (activeGuards > 0) else 1)

# Light Colors
var colors = [
	Color(0.878, 0.663, 0.086),
	Color(0.988, 0.698, 0.184, 0.78),
	Color(1, 0.741, 0.282, 0.78),
	Color(1, 0.796, 0.439, 0.78),
	Color(1, 0.914, 0.69),
	Color(1, 0.965, 0.875),
	Color(1, 1, 1)
]
