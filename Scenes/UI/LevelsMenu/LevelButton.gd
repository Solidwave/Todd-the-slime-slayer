extends Control

class_name LevelButton

@export var levelName : String

@export var levelPath : String

@onready var button : Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.text = levelName




func _on_button_pressed():
	Load.load_Scene("res://Scenes/UI/LevelsMenu/levels_ui.tscn",levelPath)
