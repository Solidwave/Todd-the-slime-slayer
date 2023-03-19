extends Resource

class_name GlobalsData

var slime_juice : int

var current_weapon : Weapon

var inventory : Inventory

func _init(data : Dictionary):
	print(data, "creating llobals")
	slime_juice = data.slime_juice
	current_weapon = Weapon.new(data.current_weapon)
	inventory = Inventory.new(data.inventory)
