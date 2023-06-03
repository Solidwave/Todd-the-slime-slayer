extends Resource

class_name GlobalsData

var slime_juice : int = 0

var current_weapon : Weapon = Weapon.new(DbManager.getItemById("weapons",1))

var inventory : Inventory = Inventory.new({})

func _init(data : Dictionary = {}):
	if data.is_empty():
		slime_juice = 0
		current_weapon = Weapon.new(DbManager.getItemById("weapons",1))
		inventory = Inventory.new()
	else:
		slime_juice = data.slime_juice
		current_weapon = Weapon.new(data.current_weapon)
		inventory = Inventory.new(data.inventory)
