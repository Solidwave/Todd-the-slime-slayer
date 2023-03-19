extends Resource

class_name Item

@export var id : String

@export var price : int

@export var item_name : String

@export var sprite : String

@export var sprite_res : Resource

func _init(item_data : Dictionary = {
	id = "1",
	price = 1,
	item_name = "Item",
	sprite = "item_data",
}):
	id = item_data.id
	
	price = item_data.price
	
	item_name = item_data.item_name
	
	sprite = item_data.sprite
	
func save():
	return {
	id = id,
	price = price,
	item_name = item_name,
	sprite = sprite
}

