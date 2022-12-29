extends Node2D

@export var preloadedEnemies := [
	preload("res://Scenes/Enemies/Slimes/Slime.tscn")
]

@onready var spawnTimer = $Timer

@export var spawnRange = 100

@export var spawnInterval = 3

@export var spawnNumber = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


func _on_timer_timeout():
	print("trying to spawn")
	var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
	
	var enemy = enemyPreload.instantiate()
	
	enemy.position = Vector2(Player.position.x + randi_range(-spawnRange,spawnRange), Player.position.y + randi_range(-spawnRange,spawnRange))
	
	get_tree().current_scene.add_child(enemy)
	spawnTimer.start(spawnInterval)
	pass # Replace with function body.
