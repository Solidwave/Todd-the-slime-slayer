extends Control

@onready var item_sprite = $HBoxContainer/SpriteContainer/ItemSprite
@onready var itemName = $HBoxContainer/Name
@onready var price = $HBoxContainer/Price

@export var item_data : Dictionary
# Called when the node enters the scene tree for the first time.
func _ready():
	print(item_data)
	item_sprite.texture = load(item_data.sprite)
	item_sprite.frame_coords = Vector2i(item_data.frameCoords.x,item_data.frameCoords.y)
	itemName.text = item_data.name
	price.text = str(item_data.price)
	
	



