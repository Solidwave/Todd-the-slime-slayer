extends Node

@onready var loading_scene = preload("res://Scenes/Load/load.tscn")

var load_value = 0

var current_scene = null

var scene_to_load = null

var load_callback : Callable

var scene_to_load_instance  = null

var loading_thread : Thread = null

var finished : bool = false


func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func _process(delta):
	if scene_to_load != null && scene_to_load_instance == null:
		print(ResourceLoader.load_threaded_get_status(scene_to_load))
		match ResourceLoader.load_threaded_get_status(scene_to_load):
			ResourceLoader.THREAD_LOAD_LOADED:
				var newScene = ResourceLoader.load_threaded_get(scene_to_load)
				
				scene_to_load_instance = newScene.instantiate()
				loading_thread = Thread.new()
				
				loading_thread.start(my_add_child)
	if finished:
		finished = false
		load_value  = 0
		scene_to_load = null
		
		if load_callback != null:
			print(load_callback)
			load_callback.call()
		scene_to_load_instance = null

		if current_scene != null:
			current_scene.free()
#
#
##		loading_thread.wait_to_finish()
		
#	if scene_to_load_instance:
#		print(load_value)
		

func load_scene(path : String):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("deferred_load_scene", path)

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
	
func my_add_child():
#	get_tree().root.call_deferred("add_child",scene_to_load_instance)
	get_tree().root.add_child(scene_to_load_instance)
	
	finished = true
	
func _exit_tree():
	loading_thread.wait_to_finish()
	

	
