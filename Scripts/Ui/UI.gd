extends CanvasLayer

func updateAmmo(amount):
	$"Inventory/Gun/0".text = str(amount)

func updateCloak(amount):
	$"Inventory/InvContainer/Hack/0".text = str(amount)
	
func updateHack(amount):
	$"Inventory/InvContainer/Hack/0".text = str(amount)
	
	
