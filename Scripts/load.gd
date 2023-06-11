extends Node


@onready var loading_scene = preload("res://Scenes/Load/load.tscn")
var load_value = 0


func set_load_value(value: float):
	load_value = value
	print(value)

func load_Scene(current_scene, next_scene):
	print(current_scene, next_scene)
	var progress = []
	
	
	get_tree().change_scene_to_packed(loading_scene)
	
	await get_tree().create_timer(0.5).timeout
	
	var loader = ResourceLoader.load_threaded_request(next_scene)
	
	var scene_load_status = ResourceLoader.load_threaded_get_status(next_scene, progress)
	print(scene_load_status)
	var progress_barr = get_tree().current_scene.get_node('MarginContainer/VBoxContainer/ProgressBar')
	print(progress_barr.value)
	while (scene_load_status == ResourceLoader.THREAD_LOAD_IN_PROGRESS):
		progress_barr.value = 0.6
		
		get_tree().current_scene.get_node('MarginContainer/VBoxContainer/ProgressBar').value = load_value

		scene_load_status = ResourceLoader.load_threaded_get_status(next_scene, progress)
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(next_scene))
	else:
		get_tree().change_scene_to_file(current_scene)
	
	
	
