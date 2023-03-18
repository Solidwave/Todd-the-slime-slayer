extends CanvasLayer

@onready var grid_container = $MarginContainer/Panel/MarginContainer/GridContainer

@export var dataPath : String


var vendor_item = preload('res://vendor_item.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.get_file_as_string(dataPath)
	
	var items : Array = JSON.parse_string(file)
	
	for item in items:
		createItemNode(item)


func createItemNode(item : Dictionary) -> void:
	var itemNode = vendor_item.instantiate()
	
	itemNode.item = Weapon.new(item)
	
	grid_container.add_child(itemNode)


func _on_close_button_pressed():
	visible = false
