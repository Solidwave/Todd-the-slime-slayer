extends Item

class_name PowerUp

@export var power_type : String

@export var duration : String

func _init(power_data : Dictionary = {
	power_type = "damage",
	duration = 30
}):
	power_type = power_data.power_type
	
	duration = power_data.duration
	

