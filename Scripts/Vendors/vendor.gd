extends RigidBody2D


@export var items : Array

var itemButton = preload("res://Scenes/Components/ItemInVendor.tscn")

@onready var LevelsContainer = $Items/GridContainer


@export_dir var dir_path

func _ready():
	get_levels(dir_path)
func get_levels(path) -> void:
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				
				var item = load(file_name)
				createLevelButton(item)
				print(dir.get_current_dir())
				
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func createLevelButton(item) -> void:
	var itemNode = itemButton.instantiate()
	
	itemButton.item = item
	
	LevelsContainer.add_child(itemNode)
