extends Control

class_name DamageComponent

@onready var label = $Label

@onready var damage_animation = $DamageAnimation

func playAnimation(damage: int) -> void:
	label.text = str(damage)
	
	damage_animation.play("damage_animation")
