extends Control

@onready var itemName = $Button/HBoxContainer/Name
@onready var price = $Button/HBoxContainer/Price
@onready var button = $Button
@onready var confirmation_dialog = $ConfirmationDialog
@onready var item_sprite = $Button/HBoxContainer/SpriteContainer/ItemSprite

@export var snackbar : Snackbar 

@export var item : Weapon
# Called when the node enters the scene tree for the first time.
func _ready():
	item_sprite.texture = load(item.sprite)
	item_sprite.frame_coords = Vector2i(item.frame_coords.x,item.frame_coords.y)
	itemName.text = item.weapon_name
	if item.owned:
		price.text = "Owned"
	else:
		price.text = str(item.price)
	


func _on_button_pressed():
	if item.owned:
		Globals.globalsData.current_weapon = item
		
		Globals.Player.updateWeapon()
		
		Globals.save_game()
	else:
		confirmation_dialog.popup_centered()
		
		confirmation_dialog.visible = true


func _on_confirmation_dialog_canceled():
	confirmation_dialog.visible = false


func _on_confirmation_dialog_confirmed():
	if item.price <= Globals.globalsData.slime_juice:
		item.owned = true
		if DbManager.updateItem("weapons",item.save()) == OK:
			Globals.globalsData.current_weapon = item
			
			Globals.Player.updateWeapon()
			
			Globals.globalsData.slime_juice = Globals.globalsData.slime_juice - item.price
			
			Globals.save_game()
			
			updateLabels()
	else:
		snackbar.set_text('You need more money!')
		snackbar.show_snackbar()

func updateLabels():
	if item.owned:
		price.text = "Owned"
	else:
		price.text = str(item.price)
