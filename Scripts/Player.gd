extends CharacterBody2D

@export var speed = 200

@export var damage = 40

@onready var animationTree = $AnimationTree
@onready var animationPlayer = $AnimationPlayer
@onready var swoosh = $Swordswoosh2
@onready var sword = $Sword



var statemachine : AnimationNodeStateMachinePlayback

func _ready():
	animationTree.active = true
	
	swoosh.visible = false
	
	sword.visible = false

	
	statemachine = animationTree.get("parameters/playback")
	
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if	Input.is_action_pressed("move_left"):
		velocity.x -= 1.0
	if	Input.is_action_pressed("move_right"):
		velocity.x += 1.0
	if	Input.is_action_pressed("move_down"):
		velocity.y += 1.0
	if	Input.is_action_pressed("move_up"):
		velocity.y -= 1.0
		
	velocity = velocity * speed
	
	statemachine.travel("Locomotion")
	
	animationTree.set("parameters/Locomotion/blend_position",velocity)
	
	if Input.is_action_just_pressed("attack"):
		var mousePosition = get_viewport().get_mouse_position()
		
		var attackDirection = ( position - mousePosition).normalized()
		
		animationTree.set("parameters/Attack/blend_position", int(round(attackDirection.x)))
		
		statemachine.travel("Attack")
		
	move_and_slide()




func _on_damage_area_body_entered(body):
	print(body)
	body.receiveDamage(damage)
	pass # Replace with function body.
