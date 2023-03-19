extends MarginContainer

@onready var texture_rect = $TextureRect/MarginContainer/TextureRect

@onready var amount_label = $TextureRect/MarginContainer/AmountLabel

@export var item : Dictionary

func _ready():
	if item!=null && !item.is_empty():
		update_slot_item(item)
	

func update_slot_item(item):
	print(item)
	var texture = load(item.item.sprite)
	amount_label.text = str(item.amount)
	texture_rect.texture = texture

