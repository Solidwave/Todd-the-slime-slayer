extends Control

class_name LevelButton

@export var levelName : String

@export var levelPath : String

@export var threaded : bool = false

@onready var button : Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.text = levelName




func _on_button_pressed():
	SceneManager.load_scene(levelPath, threaded)
