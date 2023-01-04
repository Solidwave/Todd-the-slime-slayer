extends Area2D
class_name Joystick

@onready var bigCircle = $BigCircle
@onready var smallCircle = $BigCircle/SmallCircle
@onready var joystickArea = $JoystickArea
@onready var maxDistance = $JoystickArea.shape.radius

@export var camera : Camera2D

var touched = false

func _input(event):
	if event is InputEventScreenTouch:
		print(event.position)
		event = make_input_local(event)
		print(event.position)
		
		var distance = event.position.distance_to(bigCircle.position)
		
		if not touched:
			if distance < maxDistance:
				touched = true
		else:
			touched = false
			smallCircle.position = Vector2.ZERO
			
			
func _process(delta):
	if	touched:
		smallCircle.global_position = get_global_mouse_position()
		
		smallCircle.position = bigCircle.position + (smallCircle.position - bigCircle.position).limit_length(maxDistance)

func getVelocity():
	return (smallCircle.position - bigCircle.position).normalized()
		
