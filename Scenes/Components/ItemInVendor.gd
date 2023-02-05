extends Control

@export var item : Node
@onready var sprite = $Button/Sprite
@onready var damage_label = $Button/DamageLabel
@onready var damage_value = $Button/DamageValue
@onready var price_label = $Button/PriceLabel
@onready var price_value = $Button/PriceValue

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = item.getTexture()
	sprite.frame_coords = item.getSpriteCords()
	price_value.text = item.getPrice()
	damage_value.text = item.getValue()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
