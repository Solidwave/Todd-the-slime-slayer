extends Area2D
class_name Joystick

@onready var bigCircle = $BigCircle
@onready var smallCircle = $BigCircle/SmallCircle
@onready var joystickArea = $JoystickArea
@onready var maxDistance = $JoystickArea.shape.radius

@export var camera : Camera2D

@export var bigTexture : Texture2D
@export var smallTexture : Texture2D
var state = {
	event = null,
	index = null
}

var touched = false

func _ready():
	if 	bigTexture != null:
		bigCircle.texture = bigTexture
	
	if 	smallTexture != null:
		smallCircle.texture = smallTexture
func _input(event):
	event = make_input_local(event)
	
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(bigCircle.position)
		
		if 	event.is_pressed() and distance < maxDistance * 2 and state.index == null:
			onPressed(event)
		if not event.is_pressed() and state.index == event.index:
			onReleased(event)
	if event is InputEventScreenDrag && touched && event.index == state.index:
		onDrag(event)
			
func onPressed(event):
	touched = true
	state.index = event.index
	
func onReleased(event):
	smallCircle.position = Vector2.ZERO
	touched = false
	state.index = null

func onDrag(event):
	smallCircle.position = event.position
	
	smallCircle.position = bigCircle.position + (smallCircle.position - bigCircle.position).limit_length(maxDistance -8)
#func _process(delta):
	
#	if	state.event != null:
#		smallCircle.position = to_global(state.event.position)
#
#		smallCircle.position = bigCircle.position + (smallCircle.position - bigCircle.position).limit_length(maxDistance)
	
func getVelocity():
	return (smallCircle.position - bigCircle.position).normalized()
		
