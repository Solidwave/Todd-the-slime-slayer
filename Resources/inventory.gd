extends Resource

class_name Inventory

signal update_inventory_items

var items : Dictionary

var inventory_max_size = 10

func _init(items_data : Dictionary = {}):
	items = items_data

func addItem(item : Item):
	if 	items.size() == inventory_max_size:
		return FAILED
	if items.has(item.id):
		items[item.id].amount += 1
	else:
		items[item.id] = {
			amount = 1,
			item = item.save()
		}
	emit_signal("update_inventory_items")
	return OK
		
func save():
	return items

