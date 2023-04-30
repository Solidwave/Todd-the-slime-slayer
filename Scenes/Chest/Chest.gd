extends Area2D


@export var loot_pool : Array[Loot]

@onready var animation_player = $AnimationPlayer

@onready var lootScene = preload("res://Scenes/Loot/loot.tscn")

var chosen_one : Loot

var opened = false

@export var health : int = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	chosen_one = chooseLoot()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if 	!opened && health <= 0:
		open()

func receiveHit():
	if health <= 0:
		return
	animation_player.play("hit")
	health = health - 1

func open():
	opened = true
	animation_player.play("open")
	
	

	
	
func chooseLoot() -> Loot:
	if	loot_pool.size() == 1:
		return loot_pool[0]
		
	var index = randi_range(0, loot_pool.size())
	
	return loot_pool[index]
	
func spawnLoot() -> void:
	var loot = lootScene.instantiate()
	
	loot.set("loot_data", chosen_one)
	
	loot.set("from_chest", true)
	
	loot.position = global_position
	add_child(loot)
