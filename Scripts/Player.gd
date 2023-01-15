extends CharacterBody2D

@export var speed = 200

@export var health = 15

@export var damage = 40


@onready var animationTree = $AnimationTree
@onready var animationPlayer = $AnimationPlayer
@onready var sword = $SwordMarker/Sword
@onready var GameOver = $GameOver
@onready var joystick : Joystick = $Control/VBoxContainer2/LocomotionJoystic
@onready var attackJoystick : Joystick = $Control/VBoxContainer/AttackJoystick



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
		_:
#			keyboard movemetn
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
				
			var attackDirection = attackJoystick.getVelocity()
			if attackDirection != Vector2.ZERO:
				if attackDirection.x > 0:
					attackDirection = 1
				elif attackDirection.x < 0:
					attackDirection = -1


				animationTree.set("parameters/Attack/blend_position", attackDirection)

				statemachine.travel('Attack')
				
				sword.use()
			move_and_slide()


func receiveDamage(damageReceived):
	health -= damageReceived
	print(health)
	
func die():
	GameOver.visible = true

func _on_damage_area_body_entered(body):
	if 	body.is_in_group("Enemies"):
		body.receiveDamage(damage)
	pass # Replace with function body.
