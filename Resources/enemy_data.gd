extends Resource

class_name Enemy

@export var health : int

@export var damage : int

@export var speed : int

@export var loot : Array[int]

func _init(enemy_data : Dictionary = {
	health = 10,
	damage = 1,
	speed = 10,
	loot = []
}):
	health = enemy_data.health
	
	damage = enemy_data.damage
	
	speed = enemy_data.speed
	
	loot = enemy_data.loot
