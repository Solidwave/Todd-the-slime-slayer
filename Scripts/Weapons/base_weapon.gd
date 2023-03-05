extends Resource

class_name Weapon

@export var damage : int = 3

@export var frameCoords : Vector2i

@export var weapon_name : String

@export var sprite : String

@export var type : String

@export var price : int = 1

@export var id : int

@export var owned : bool

func _init(item_data : Dictionary):
	damage = item_data.damage
	
	frameCoords = Vector2i(item_data.frameCoords.x, item_data.frameCoords.y)
	
	weapon_name = item_data.itemName
	
	sprite = item_data.sprite
	
	type = item_data.type
	
	price = item_data.price
	
	id = item_data.id
	
	owned = item_data.owned

func use():
	pass
	
func save():
	return {
		"damage" = damage,
		"frameCoords" = {
			"x" = frameCoords.x,
			"y" = frameCoords.y
		},
		"type" = type, 
		"id" = id,
		"owned" = owned,
		"price" = price,
		"sprite" = sprite
	}
