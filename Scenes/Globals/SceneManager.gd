extends Node

@onready var loading_scene = preload("res://Scenes/Load/load.tscn")


var current_scene = null

var scene_to_load = null

var load_callback : Callable = Callable()

var scene_to_load_instance  = null

var loading_thread : Thread = null

var finished : bool = false

var loading = false

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func _process(delta):
	if scene_to_load != null && scene_to_load_instance == null:
		loading = true
		match ResourceLoader.load_threaded_get_status(scene_to_load):
			ResourceLoader.THREAD_LOAD_LOADED:
				var newScene = ResourceLoader.load_threaded_get(scene_to_load)
				
				scene_to_load_instance = newScene.instantiate()
				
				get_tree().root.call_deferred("add_child",scene_to_load_instance)
				
	if finished:
		finished = false
		loading = false
		
		
		if current_scene != null:
			current_scene.free()

func load_scene(path : String, threaded: bool = false):
	if threaded:
		call_deferred("deferred_load_scene", path)
	else:
		var root = get_tree().root
	
		current_scene = root.get_child(root.get_child_count() - 1)
		
		scene_to_load = path
		
		# It is now safe to remove the current scene
		get_tree().change_scene_to_file(path)
		

func deferred_load_scene(path: String, loading: bool = false):
	var root = get_tree().root
	
	current_scene = root.get_child(root.get_child_count() - 1)
	
	scene_to_load = path
	
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	# Instance the new scene.
	current_scene = loading_scene.instantiate()
	
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
	ResourceLoader.load_threaded_request(path)

func _exit_tree():
	loading_thread.wait_to_finish()
	

	
