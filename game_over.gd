extends Control



func _on_menu_pressed():
	get_tree().change_scene_to_file("res://control.tscn")


func _on_retry_pressed():
	get_tree().reload_current_scene()
func _on_quit_pressed():
	get_tree().quit()
