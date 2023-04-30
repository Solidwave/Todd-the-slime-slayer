extends MarginContainer

class_name Snackbar
@onready var animation_player = $AnimationPlayer
@onready var label = $TextureRect/MarginContainer/Label
@onready var timer = $Timer

var showing = false

func show_snackbar():
	animation_player.play("show_snackbar")
	showing = true
	
	timer.start()

func hide_snackbar():
	
	timer.stop()
	
	animation_player.play_backwards("show_snackbar")
	showing = false
	

func _on_timer_timeout():
	hide_snackbar()

func set_text(text: String):
	label.text = text


func _on_texture_button_pressed():
	hide_snackbar()
	
func _input(event):
	if showing && event is InputEventMouseButton:
		hide_snackbar()
		

