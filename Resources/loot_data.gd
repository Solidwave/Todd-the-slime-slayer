extends Item

class_name Loot

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
	super(loot_data)
	
	rarity = loot_data.rarity
	
	sprite = load(loot_data.sprite)
	
	
	

