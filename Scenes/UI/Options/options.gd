extends Control


@onready var animation_player = $"../AnimationPlayer"



func _on_game_play_ui_open_options():
	visible = true;
	get_tree().paused = true


func _on_button_pressed():
	animation_player.play("close_options")
	
