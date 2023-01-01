extends Node2D

class_name VelocityComponent

@export var speed : float = 10

@export var acceleration : float = 0

var velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Globals.Player.position - position


func getVelocity():
	return velocity * speed

func setVelocity(vel):
	velocity = vel
