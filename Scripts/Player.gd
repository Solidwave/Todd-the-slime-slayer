extends CharacterBody2D

@export var speed = 200

@export var health = 15

@export var damage = 40


@onready var animationTree = $AnimationTree
@onready var animationPlayer = $AnimationPlayer
@onready var swoosh = $Swordswoosh2
@onready var sword = $SwordMarker/Sword
@onready var GameOver = $GameOver
@onready var joystick : Joystick = $Camera2D/Joystick



var statemachine : AnimationNodeStateMachinePlayback

func _ready():
	Globals.Player = self
	
	animationTree.active = true
	
	statemachine = animationTree.get("parameters/playback")
	
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if health <= 0:
		statemachine.travel("Death")
	
	var currentState : String = statemachine.get_current_node()
	match currentState:
		'Death':
			velocity = Vector2.ZERO
		'Locomotion':
#			if	Input.is_action_pressed("move_left"):
#				velocity.x -= 1.0
#			if	Input.is_action_pressed("move_right"):
#				velocity.x += 1.0
#			if	Input.is_action_pressed("move_down"):
#				velocity.y += 1.0
#			if	Input.is_action_pressed("move_up"):
#				velocity.y -= 1.0
			velocity = joystick.getVelocity()
				
			velocity = velocity * speed
			
			animationTree.set("parameters/Locomotion/blend_position",velocity)
	
			if Input.is_action_just_pressed("attack"):
				var attackDirection
				if get_global_mouse_position().x > global_position.x:
					attackDirection = 1
				elif get_global_mouse_position().x < global_position.x:
					attackDirection = -1


				animationTree.set("parameters/Attack/blend_position", attackDirection)

				statemachine.travel('Attack')
				
				sword.use()
			move_and_slide()


func receiveDamage(damage):
	health -= damage
	print(health)
	
func die():
	GameOver.visible = true

func _on_damage_area_body_entered(body):
	if 	body.is_in_group("Enemies"):
		body.receiveDamage(damage)
	pass # Replace with function body.
