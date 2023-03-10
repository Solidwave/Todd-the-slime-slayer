extends Node2D

@export var preloadedEnemies := [
	preload("res://Scenes/Enemies/Slimes/Slime.tscn")
]

@export var lootScene = preload("res://loot.tscn")

@onready var spawnTimer = $Timer
@onready var navAgent = $NavigationAgent2D

@export var spawnRange = 100

@export var navRegion : NavigationRegion2D

@export var enemiesParent : Node2D

@export var maxEnemies = 20

@export var spawnInterval = 3

@export var spawnNumber = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


func _on_timer_timeout():
	if get_tree().get_nodes_in_group("Enemies").size() < maxEnemies:
		
		navAgent.target_position = Vector2(Globals.Player.position.x + randi_range(-spawnRange,spawnRange), Globals.Player.position.y + randi_range(-spawnRange,spawnRange))
		
		while !navAgent.is_target_reachable():
			navAgent.target_position = Vector2(Globals.Player.position.x + randi_range(-spawnRange,spawnRange), Globals.Player.position.y + randi_range(-spawnRange,spawnRange))
		var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
		
		var enemy : Node = enemyPreload.instantiate()
		
		enemy.position = navAgent.target_position
		
		enemy.connect("enemy_died",_on_enemy_died)
		
		if enemiesParent != null:
			enemiesParent.add_child(enemy)
		else:
			add_child(enemy)

func _on_enemy_died(drops : Array[int], position: Vector2):
	var roll = randf() 
	
	var tmpLoot : Array = drops.map(func(id): return DbManager.getItemById("loot", id))
	
	for loot in tmpLoot.filter(func(loot): return loot.rarity >= roll):
		var lootObject : Node2D = lootScene.instantiate()
		
		lootObject.set("loot_data", Loot.new(loot))
		
		lootObject.position = position
		
		if enemiesParent != null:
			enemiesParent.add_child(lootObject)
		else:
			add_child(lootObject)
		
		
	


