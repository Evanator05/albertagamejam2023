extends Node

var items = {
	0: {
		"Name":"Stun Gun",
		"Type":"Weapon",
		"Desc":"A stun gun to STUN your enemies. Temporary effect.",
		"Icon": preload("res://icon.svg")
	},
	1: {
		"Name":"Hacking Device",
		"Type":"Device",
		"Desc":"A hacking device. To HACK.",
		"Icon": preload("res://icon.svg")
	},
	2: {
		"Name":"Invisibility Cloak",
		"Type":"Device",
		"Desc":"Invisibility cloak to become INVISIBLE. Temporary effect.",
		"Icon":preload("res://icon.svg")
	}
}

var inventory = {
	
}

func addItem(itemName):
	var hasItem = false
	for i in inventory:
		if inventory[i]["Name"] == itemName:
			inventory[i]["Count"] += 1
			hasItem = true
	if hasItem == false:
		for i in items:
			if items[i]["Name"] == itemName:
				var tempDict = items[i]
				tempDict["Count"] = 1
				inventory[inventory.size()] = tempDict
				
func removeItem(itemName):
	var hasItem = true
	for i in inventory:
		if inventory[i]["Name"] == itemName:
			inventory[i]["Count"] -= 1
			hasItem = false
		else:
			hasItem = false 
	
