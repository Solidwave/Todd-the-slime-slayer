extends Node2D
var Player

var save_name = "Globals"

var globalsData : GlobalsData = GlobalsData.new({
	slime_juice = 0,
	current_weapon = {
		item_name = "Sword",
		id = 1,
		type = "sword",
		damage = {
			min = 8,
			max = 10,
			crit_multiplier = 1.5,
			crit_chance = 0.1
		},
		price = 10,
		frame_coords = {
			x = 0,
			y =0
		},
		sprite = "res://Sprites/Weapons/Swords/Swords.png",
		owned = true
	}
})



func increaseSlimeJuice(amount: int):
	globalsData.slime_juice += amount

func _ready():
	var save_file = FileAccess.open("user://saves/savegame.save", FileAccess.READ)
	if save_file == null:
		return
	var data = save_file.get_as_text()
	data = JSON.parse_string(data)
	if data == null:
		return
	if data[save_name] != null:
		globalsData = GlobalsData.new(data[save_name])
	
	

func save():
	print('test')
	print(globalsData)
	var save_dict = {
		"slime_juice": globalsData.slime_juice,
		"current_weapon": globalsData.current_weapon.save()
	}
	
	return save_dict
	
	
func save_game():
	var save_dir = DirAccess.open("user://")
	save_dir.make_dir("saves")
	var save_file = FileAccess.open("user://saves/savegame.save", FileAccess.WRITE)
	
	var json : Dictionary = {}
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	#save globals
	var jsonGlobalsData = save()
	
	json[save_name] = jsonGlobalsData
	for node in save_nodes:
		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		# Call the node's save function.
		var node_data = node.call("save")
		print("persistent node found %s" % node.name)
		print(node_data)
		json[node.name] = node_data
		# Store the save dictionary as a new line in the save file.
	save_file.store_string(JSON.stringify(json, "\t"))
