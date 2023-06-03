extends Node

const files : Dictionary = {
	"weapons" = "res://database/weapons.json",
	"loot" = "res://database/loot.json"
}

func updateItem(file, item : Dictionary):
	print("Saving item.. {}", file, item)
	var databaseFile = FileAccess.open(files[file], FileAccess.READ)
	if databaseFile == null:
		return FAILED
	var database = databaseFile.get_as_text()
	if database == null:
		return FAILED
	
	
	var databaseArray : Array = JSON.parse_string(database)
	for element in databaseArray:
		if item.id == element.id:
			element = item
			
			databaseFile = FileAccess.open(files[file], FileAccess.WRITE)
			
			databaseFile.store_string(JSON.stringify(databaseArray, "\t"))
			
			return OK
	
	return FAILED
	
func getItemById(file: String,id: int):
	print("Getting item:", file, id)
	var databaseFile = FileAccess.open(files[file], FileAccess.READ)
	if databaseFile == null:
		return FAILED
	var database = databaseFile.get_as_text()
	if database == null:
		return FAILED
	
	var databaseArray : Array = JSON.parse_string(database)
	for element in databaseArray:
		if id == element.id:
			return element
	
	return FAILED
		
		
	
	
