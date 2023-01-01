extends Node2D

@onready var _animation_player := $AnimationPlayer

@export var pivot : Marker2D = Marker2D.new()

@export var damage = 40


var animating = false

func use() -> void:
	var mouse_position := get_global_mouse_position()

	pivot.look_at(mouse_position)

	# Flip pivot to avoid upside down attacks
	if mouse_position.x - global_position.x < 0:
		pivot.scale.y = -1
	else:
		pivot.scale.y = 1
		
	_animation_player.play("Attack")

func _on_hit_box_body_entered(body):
	if	body.is_in_group("Enemies"):
		body.receiveDamage(damage)
