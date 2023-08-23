class_name LightColor extends OmniLight3D

func _ready():
	light_color = Globals.colors[Globals.mapSections.currentLevel]
