extends Control

signal close_inventory

var inventory : Inventory
@onready var grid_container = $MarginContainer/TabContainer/Loot/MarginContainer/GridContainer

var inventory_slot = preload("res://inventory_slot.tscn")

var free_slot_index : int = 0

func _ready():
	visible = false
	inventory = Globals.globalsData.inventory
	for i in inventory.inventory_max_size:
		var slot = inventory_slot.instantiate()
		grid_container.add_child(slot)
	
	update_items()
	
	inventory.update_inventory_items.connect(update_items)

func show_inventory():
	visible = true


func _on_game_play_ui_open_inventory():
	visible = true
	get_tree().paused = true
	


func _on_texture_button_pressed():
	emit_signal("close_inventory")
	visible = false
	
func update_items():
	inventory = Globals.globalsData.inventory
	
	
	for key in inventory.items:
		var slot =  grid_container.get_child(free_slot_index)
		
		free_slot_index += 1
		slot.update_slot_item(inventory.items[key])
	free_slot_index = 0

