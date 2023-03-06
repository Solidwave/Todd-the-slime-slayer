extends CharacterBody2D



@export var speed = 200
@export var swordScene : PackedScene

@export var health = 15

@export var damage = 40

@onready var gameplayUI : GameplayUI = $CanvasLayer/GamePlayUI

@onready var animationTree = $AnimationTree
@onready var animationPlayer = $AnimationPlayer
@onready var swordMarker = $SwordMarker
@onready var GameOver = $GameOver

var locomotionJoystick : Joystick

var attackJoystick : Joystick

var currentWeapon : Weapon

var sword

var statemachine : AnimationNodeStateMachinePlayback

var dead = false
func _ready():
	Globals.Player = self
	currentWeapon = Globals.globalsData.current_weapon
	
	print(currentWeapon)
	
	animationTree.active = true
	
	
	sword = swordScene.instantiate()
	print(typeof(sword))
	
	attackJoystick = gameplayUI.getAttackJoystick()
	
	locomotionJoystick = gameplayUI.getLocomotionJoystick()
	
	sword.set("attackJoystick", attackJoystick)
	
	sword.set("weapon_data" ,currentWeapon)
	
	sword.set("pivot",swordMarker)
	
	swordMarker.add_child(sword)
#	sword.setup(currentWeapon.save())
	
	
	statemachine = animationTree.get("parameters/playback")
	
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	if	dead:
		return
	if health <= 0:
		statemachine.travel("Death")
		dead = true 
		return
		
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
			velocity = gameplayUI.getLocomotionJoystick().getVelocity()
				
			velocity = velocity * speed
			
			animationTree.set("parameters/Locomotion/blend_position",velocity)
				
			var attackDirection = gameplayUI.getAttackJoystick().getVelocity()
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
	
func die():
	GameOver.visible = true
	Globals.save_game()

func _on_damage_area_body_entered(body):
	if 	body.is_in_group("Enemies"):
		body.receiveDamage(damage)
		
func save():
	var save_data = {
		"health": health
	}
	
	return save_data
	
func updateWeapon():
	currentWeapon = Globals.globalsData.current_weapon
	
	sword.weapon_data = currentWeapon
	
	sword.set("pivot",swordMarker)
	
	sword.set("frame_coords", Vector2i(currentWeapon.frame_coords.x,currentWeapon.frame_coords.y))
	
	sword.setSpriteCoords(currentWeapon.frame_coords)

