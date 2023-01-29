extends CharacterBody2D

class_name Enemy
@export var speed = 100
@export var health = 100
@export var jumpRate = 1000
@export var jumpDistance = 200
@export var knockBackForce = 200
@export var slimeValue = 1
@export var attackDistance = 50
@export var damage = 1
@export var jumpDamage = 2


@onready var enemySprite : Sprite2D = $Sprites/Enemies
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var animationTree : AnimationTree = $AnimationTree
@onready var navAgent : NavigationAgent2D = $NavigationAgent2D
@onready var landingParticle : CPUParticles2D = $LandingParticle
@onready var attackShape : CollisionShape2D = $Sprites/AttackArea/AttackShape



var knockBack: Vector2 = Vector2.ZERO;
var tmpKnockBackForce = 0
var stateMachine : AnimationNodeStateMachinePlayback
var targetPosition : Vector2
var sprites = []
var jumpDirection = null

func _ready():
	sprites = [load("res://Sprites/Slimes/slime_blue.png"),load("res://Sprites/Slimes/slime_red.png"),load("res://Sprites/Slimes/slime_green.png")]
	
	randomize()
	
	animationTree.active = true
	
	enemySprite.texture = sprites[randi_range(0, len(sprites)-1)]
	
	var tmpImage = enemySprite.texture.get_image();
	
	var color = tmpImage.get_pixel(16,16)
	
	landingParticle.color = color
	
	stateMachine = animationTree.get('parameters/playback')
	
func _physics_process(delta):
	if	health <= 0:
		stateMachine.travel("Die")
		return
		
	var currentState : String = stateMachine.get_current_node()
	
	var playerDirection = Globals.Player.global_position - global_position
	
	match currentState:
		'Attack':
			velocity = Vector2.ZERO
		'Stunned':
			velocity = knockBack * tmpKnockBackForce
			tmpKnockBackForce = tmpKnockBackForce - 200 * delta
			jumpDirection = null
		'Jump':
			if jumpDirection == null:
				jumpDirection = Globals.Player.global_position - global_position
				
			velocity = jumpDirection 
		'Idle':
			var distanceToPlayer = global_position.distance_to(Globals.Player.global_position)
			
			navAgent.target_location = Globals.Player.global_position
			
			var navDirection = navAgent.get_next_location()
			
			velocity = global_position.direction_to(navDirection) * speed
			
			if distanceToPlayer <= attackDistance:
				stateMachine.travel("Attack")
				targetPosition = Globals.Player.global_position - global_position
			
			randomize()
			
			var jump = randi_range(0, jumpRate)
			
			jumpDirection = null
			
	
			if 	jump == 1 && distanceToPlayer <= jumpDistance:
				stateMachine.travel('Jump')
				return
		_:
			print(currentState, 'no match found')
	if	playerDirection.x < 0:
		attackShape.position.x = -30
		enemySprite.flip_h = true
	elif playerDirection.x > 0:
		attackShape.position.x = 30
		enemySprite.flip_h = false
		
	move_and_slide()
	
func receiveDamage(damage):
	knockBack = global_position - Globals.Player.global_position
	
	knockBack = knockBack.normalized() 
	
	tmpKnockBackForce = knockBackForce
	
	health -= damage
	
	stateMachine.travel("Stunned")
	

func die():
	Globals.increaseSlimeJuice(slimeValue)
	queue_free()


func _on_attack_area_body_entered(body):
	print("body entered")
	if body.is_in_group("Player"):
		if stateMachine.get_current_node() == "Attack":
			print("attack")
			body.receiveDamage(damage)
		if stateMachine.get_current_node() == "Jump":
			body.receiveDamage(jumpDamage)
