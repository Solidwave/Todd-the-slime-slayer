extends Resource

class_name Weapon

@export var damage : Dictionary = {
			min = 8,
			max = 10,
			crit_multiplier = 1.5,
			crit_chance = 0.1
		}

@export var item_name : String

@export var frame_coords : Vector2i

@export var weapon_name : String

@export var sprite : String

@export var type : String

@export var price : int = 1

@export var id : int

@export var owned : bool

func _init(item_data : Dictionary):
	damage = item_data.damage
	
	frame_coords = Vector2i(item_data.frame_coords.x, item_data.frame_coords.y)
	
	weapon_name = item_data.item_name
	
	sprite = item_data.sprite
	
	type = item_data.type
	
	price = item_data.price
	
	id = item_data.id
	
	item_name =  item_data.item_name
	
	owned = item_data.owned

func use():
	pass

func calcolate_damage() -> int:
	var baseDamage = randi_range(damage.min, damage.max)
	
	var isCrit = damage.crit_chance >= randf()
	
	if isCrit:
		baseDamage = baseDamage * damage.crit_multiplier
	print(baseDamage)
	return baseDamage
	
func save():
	return {
		"damage" = damage,
		"frame_coords" = {
			"x" = frame_coords.x,
			"y" = frame_coords.y
		},
		"type" = type, 
		"id" = id,
		"owned" = owned,
		"price" = price,
		"sprite" = sprite,
		"item_name" = item_name 
	}
