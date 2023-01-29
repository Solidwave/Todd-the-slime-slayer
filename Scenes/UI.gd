extends Control

@onready var monstersAliveValue = $HBoxcontainer/MonstersAliveValue
@onready var juiceValue = $HBoxContainer/JuiceValue
@onready var heartContainer = $HeartContainer

var previousHealth
# Called when the node enters the scene tree for the first time.
func _ready():
	juiceValue.text = str(Globals.globalsData.slimeJuice)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	monstersAliveValue.text = str(get_tree().get_nodes_in_group('Enemies').size())
	
	juiceValue.text = str(Globals.globalsData.slimeJuice)
	
	if previousHealth != Globals.Player.health:
		updateHearts(Globals.Player.health)
	pass


func updateHearts(health):
	previousHealth = Globals.Player.health
	var hearts = heartContainer.get_children()
	for i in len(hearts):
		var maxHeartValue = (i+1)*3
		if 	maxHeartValue <= health:
			hearts[i].frame = 0
		if (maxHeartValue - health) >= 3:
			hearts[i].frame = 3
		else:
			hearts[i].frame = maxHeartValue - health
		
	
	
		
		
