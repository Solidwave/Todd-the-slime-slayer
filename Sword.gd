extends  Weapon

class_name Sword


@onready var _animation_player := $AnimationPlayer

@export var pivot : Marker2D = Marker2D.new()

@export var attackJoystick : Joystick

@onready var swordSprite = $Node2D/Sword

var animating = false

func _ready():
	print(frame_coords, damage, swordSprite)
	swordSprite.frame_coords = frame_coords


func setup(item_data : Dictionary):
	damage = item_data.damage
	
	frame_coords = Vector2i(item_data.frame_coords.x, item_data.frame_coords.y)
	
	weapon_name = item_data.item_name
	
	sprite = item_data.sprite
	
	type = item_data.type
	
	price = item_data.price
	
	id = item_data.id
	
	item_name =  item_data.item_name
	
	owned = item_data.owned

func use() -> void:
	var attackDirection = attackJoystick.getVelocity()
	
	pivot.look_at(global_position + attackDirection * 100)

	# Flip pivot to avoid upside down attacks
	if attackDirection.x < 0:
		pivot.scale.y = -1
	else:
		pivot.scale.y = 1
		
	_animation_player.play("Attack")

func _on_hit_box_body_entered(body):
	if	body.is_in_group("Enemies"):
		body.receiveDamage(calcolate_damage())

func getSpriteCoords():
	return swordSprite.frame_coords
	
func getTexture():
	return swordSprite.texture

func setSpriteCoords(new_frame_coords : Vector2i):
	print('setting new sprite coords')
	swordSprite.frame_coords = new_frame_coords
