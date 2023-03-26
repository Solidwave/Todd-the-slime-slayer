extends Node2D

@export var my_texture : Resource

@export var points : PackedVector2Array

func _draw():
	draw_line(Vector2.ZERO, Vector2.LEFT * 300, Color.GOLD)
	
