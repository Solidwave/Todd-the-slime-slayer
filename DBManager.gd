extends Node

const files : Dictionary = {
	"weapons" = "res://database/weapons.json"
}

func updateItem(file, item : Dictionary):
	print("Saving item.. {}", file, item)
	var databaseFile = FileAccess.open(files[file], FileAccess.READ_WRITE)
	if databaseFile == null:
		return FAILED
	var database = databaseFile.get_as_text()
	if database == null:
		return FAILED
	
	var databaseArray : Array = JSON.parse_string(database)
	
	for element in databaseArray:
		if item.id == element.id:
			element = item
			databaseFile.store_string(JSON.stringify(databaseArray, "\t"))
			print("updated")
			return OK
	
	return FAILED
		
	
	
