extends Control
class_name GameplayUI

@onready var monstersAliveValue = $HBoxcontainer/MonstersAliveValue
@onready var juiceValue = $MarginContainer/VBoxContainer/HBoxContainer/JuiceValue
@onready var heartContainer = $HeartContainer
@onready var locomotionJoystick : Joystick = $Locomotion/Joystick
@onready var attackJoystick : Joystick = $Attack/Joystick
@onready var pause_label = $PauseLabel
@onready var animation_player = $AnimationPlayer
@onready var options_menu = $OptionsMenu

signal open_inventory()

signal open_options

var previousHealth
# Called when the node enters the scene tree for the first time.
func _ready():
	juiceValue.text = str(Globals.globalsData.slime_juice)
	
	pause_label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	monstersAliveValue.text = str(get_tree().get_nodes_in_group('Enemies').size())
	
	juiceValue.text = str(Globals.globalsData.slime_juice)
	
	if Globals.Player != null && previousHealth != Globals.Player.health:
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
		
func getAttackJoystick() -> Joystick:
	return attackJoystick

func getLocomotionJoystick() -> Joystick:
	return locomotionJoystick


func _on_inventory_button_pressed():
	emit_signal("open_inventory")



func _on_touch_screen_button_pressed():
	emit_signal("open_inventory")


func _on_inventory_ui_close_inventory():
	get_tree().paused = false


func _on_inventory_pressed():
	emit_signal("open_inventory")


func _on_pause_pressed():
	
	if	get_tree().paused:
		animation_player.play_backwards("label_appear")
	else:
		animation_player.play("label_appear")
		
	get_tree().paused = !get_tree().paused


func _on_options_pressed():
	emit_signal("open_options")
