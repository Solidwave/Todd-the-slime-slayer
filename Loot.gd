extends Node2D

class_name Loot

@onready var sprite_node = $Sprite

@export var id : int

@export var item_name : String

@export var price : int

@export var sprite : Resource

@export var rarity: String

@export var effect : Dictionary

func setup(loot_data: Dictionary):
	id = loot_data.id
	
	item_name = loot_data.item_name 
	
	price = loot_data.id 
	
	rarity = loot_data.rarity
	
	effect = loot_data.effect
	
	sprite = load(loot_data.sprite)
	
	sprite_node.texture = sprite
	
	
	
	

