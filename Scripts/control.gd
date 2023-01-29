extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	pass # Replace with function body.


func _on_endlessmode_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	pass # Replace with function body.


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_levels_pressed():
	get_tree().change_scene_to_file("res://levels_ui.tscn")
	
	pass # Replace with function body.
