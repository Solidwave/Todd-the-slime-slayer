extends Control

@onready var monstersAliveValue = $HBoxcontainer/MonstersAliveValue
@onready var juiceValue = $HBoxContainer/JuiceValue
@onready var heartContainer = $HeartContainer

var previousHealth
# Called when the node enters the scene tree for the first time.
func _ready():
	juiceValue.text = '0'
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	monstersAliveValue.text = str(get_tree().get_nodes_in_group('Enemies').size())
	
	juiceValue.text = str(Globals.slimeJuice)
	
	if previousHealth != Globals.Player.health:
		updateHearts(Globals.Player.health)
	pass


func updateHearts(health):
	previousHealth = Globals.Player.health
	print(previousHealth)
	for i in health:
		if i + 3 < health:
			heartContainer.get_child(int(i/3)).frame = 0
		else:
			print(health-i)
				
		
