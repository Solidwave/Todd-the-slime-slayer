extends Node2D

@export var preloadedEnemies := [
	preload("res://Scenes/Enemies/Slimes/Slime.tscn")
]

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
		
		navAgent.target_location = Vector2(Globals.Player.position.x + randi_range(-spawnRange,spawnRange), Globals.Player.position.y + randi_range(-spawnRange,spawnRange))
		
		while !navAgent.is_target_reachable():
			navAgent.target_location = Vector2(Globals.Player.position.x + randi_range(-spawnRange,spawnRange), Globals.Player.position.y + randi_range(-spawnRange,spawnRange))
		var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
		
		var enemy = enemyPreload.instantiate()
		
		enemy.position = navAgent.target_location
		
		if enemiesParent != null:
			enemiesParent.add_child(enemy)
		else:
			add_child(enemy)
	pass # Replace with function body.
