extends  Node2D

@onready var _animation_player := $AnimationPlayer

@export var pivot : Marker2D = Marker2D.new()

@export var attackJoystick : Joystick

@onready var swordSprite = $Node2D/Sword

@export var weapon_data: Weapon

var animating = false

func _ready():
	swordSprite.frame_coords = weapon_data.frame_coords



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
		body.receiveDamage(weapon_data.calcolate_damage())

func getSpriteCoords():
	return swordSprite.frame_coords
	
func getTexture():
	return swordSprite.texture

func setSpriteCoords(new_frame_coords : Vector2i):
	print('setting new sprite coords')
	swordSprite.frame_coords = new_frame_coords
