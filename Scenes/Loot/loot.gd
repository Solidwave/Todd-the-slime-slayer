extends RigidBody2D

@onready var sprite = $Sprites/Sprite

@export var loot_data : Loot

@onready var animation_player = $AnimationPlayer

@export var pickUpRadius : int = 100

@export var from_chest = false

var active = true

var first_frame = true
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = load(loot_data.sprite)
	
	
	
#	if from_chest:
#		active = false
#		animation_player.play("chest")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if first_frame:
		apply_central_impulse(Vector2(randf(),randf()) * 10)
		first_frame = false
	
	if active && global_position.distance_to(Globals.Player.global_position) < pickUpRadius:
		var direction = Globals.Player.global_position - global_position
		
		apply_central_force(direction)


func _on_area_2d_body_entered(body):
	if	body.name == 'Player':
		Globals.globalsData.inventory.addItem(loot_data)
	queue_free()
	
func activate():
	active = true
