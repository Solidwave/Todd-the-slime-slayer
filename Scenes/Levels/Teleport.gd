extends Area2D

@export var sceneToLoad : String



func _on_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file(sceneToLoad)
