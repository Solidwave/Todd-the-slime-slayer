extends Control

var levels = []

var levelButton = preload('res://Scenes/UI/LevelsMenu/LevelButton.tscn')

@onready var LevelsContainer = $Panel/MarginContainer/LevelsContainer


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
				if file_name.ends_with("tscn"):
					createLevelButton(dir.get_current_dir() + '/' + file_name, file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func createLevelButton(levelPath: String, levelName: String) -> void:
	print(levelName)
	var levelNode = levelButton.instantiate()
	levelNode.levelName = levelName
	
	levelNode.levelPath = levelPath
	
	LevelsContainer.add_child(levelNode)
