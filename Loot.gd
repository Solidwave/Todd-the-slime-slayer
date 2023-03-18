extends CharacterBody2D

@onready var sprite = $Sprites/Sprite

@export var loot_data : Loot

@onready var animation_player = $AnimationPlayer

@export var pickUpRadius : int = 100

@export var from_chest = false

var active = true
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = loot_data.sprite
	
	
	
	if from_chest:
		active = false
		animation_player.play("chest")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active && global_position.distance_to(Globals.Player.global_position) < pickUpRadius:
		velocity = Globals.Player.global_position - global_position
		move_and_slide()


func _on_area_2d_body_entered(body):
	if	body.name == 'Player':
		Globals.globalsData.inventory.addItem(loot_data)
	queue_free()
	
func activate():
	active = true
