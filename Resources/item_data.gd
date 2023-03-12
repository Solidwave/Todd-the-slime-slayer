extends Resource

class_name Item

@export var id : int

@export var price : int

@export var item_name : String

func _init(item_data : Dictionary = {
	id = 1,
	price = 1,
	item_name = "Item"
}):
	id = item_data.id
	
	price = item_data.price
	
	item_name = item_data.item_name
	
func save():
	return {
	id = id,
	price = price,
	item_name = item_name
}

