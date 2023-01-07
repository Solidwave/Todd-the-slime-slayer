extends Node2D

@onready var _animation_player := $AnimationPlayer

@export var pivot : Marker2D = Marker2D.new()

@export var damage = 40

@export var attackJoystick : Joystick


var animating = false

func use() -> void:
	var attackDirection = attackJoystick.getVelocity()
	print(attackDirection)

	pivot.look_at(global_position + attackDirection * 100)

	# Flip pivot to avoid upside down attacks
	if attackDirection.x < 0:
		pivot.scale.y = -1
	else:
		pivot.scale.y = 1
		
	_animation_player.play("Attack")

func _on_hit_box_body_entered(body):
	if	body.is_in_group("Enemies"):
		body.receiveDamage(damage)
