extends Control
class_name VendorUI

@onready var grid_container = $MarginContainer/Panel/MarginContainer/ScrollContainer/GridContainer

@export var dataPath : String
@onready var snackbar = $Snackbar


var vendor_item = preload('res://Scenes/UI/VendorUI/vendor_item.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.get_file_as_string(dataPath)
	
	var items : Array = JSON.parse_string(file)
	
	for item in items:
		createItemNode(item)


func createItemNode(item : Dictionary) -> void:
	var itemNode = vendor_item.instantiate()
	
	itemNode.item = Weapon.new(item)
	itemNode.snackbar = snackbar
	
	grid_container.add_child(itemNode)


func _on_close_button_pressed():
	visible = false
