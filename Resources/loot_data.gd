extends Resource

class_name Loot


@export var id : int

@export var item_name : String

@export var price : int

@export var sprite : Resource

@export var rarity : float

@export var effect : Dictionary

func _init(loot_data = {
	id = 1,
	item_name = 'banana',
	price = 1,
	rarity = 0.5,
	effect = {
		type = 'heal',
		amount = 3
	},
	sprite = "res://Sprites/sword.png"
}):
	id = loot_data.id
	
	item_name = loot_data.item_name 
	
	price = loot_data.id 
	
	rarity = loot_data.rarity
	
	effect = loot_data.effect
	
	sprite = load(loot_data.sprite)
	
	
	

