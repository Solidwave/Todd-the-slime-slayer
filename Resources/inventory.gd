extends Resource

class_name Inventory

var items : Dictionary

func _init(items : Dictionary = {}):
	items = items

func addItem(item):
	print(items)
	if items.has(item.id):
		items[item.id].amount += 1
	else:
		items[item.id] = {
			amount = 1,
			item = item
		}
		
func save():
	return items

