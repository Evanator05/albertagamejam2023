extends Node

var currentLevel = 0;
var levels = [
	preload("res://Scenes/Level.tscn"),
	preload("res://Scenes/Level 1.tscn"),
	preload("res://Scenes/Level 2.tscn"),
	preload("res://Scenes/Level 4.tscn")
];

func nextLevel():
	print(currentLevel, levels[currentLevel])
	currentLevel+=1;
	get_tree().change_scene_to_packed(levels[currentLevel])
