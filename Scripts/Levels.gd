extends Node

var currentLevel = 0;
var levels = [
	"res://Scenes/Level.tscn",
	"res://Scenes/Level 1.tscn"
];

func nextLevel():
	currentLevel+=1;
	get_tree().change_scene(levels[currentLevel])
