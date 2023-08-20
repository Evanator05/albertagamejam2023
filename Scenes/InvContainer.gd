extends GridContainer

@onready var slot = preload("res://Inventory/Slot.tscn")
var invSize = 3

func _ready():
	for i in invSize:
		var slotTemp = slot.instantiate()
		add_child(slotTemp)
	fillInventorySlots()

func fillInventorySlots():
		pass
	
