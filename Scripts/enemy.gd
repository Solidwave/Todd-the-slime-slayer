extends CharacterBody2D

@export var speed = 100

@export var health = 100



@onready var enemiesSprite : Sprite2D = $Enemies

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

var knockBack: Vector2 = Vector2.ZERO;

var rnd = RandomNumberGenerator.new()

func _ready():
	
	rnd.randomize()
	
	enemiesSprite.frame = rnd.randi_range(0,2)
func _physics_process(delta):
	if	health <= 0:
		die()
		
	rnd.randomize()
	
	var jump = rnd.randi_range(0,5)
	if 	jump == 1:
		print(jump)
		animationPlayer.play("jump")
	
	var playerDirection : Vector2 =  Player.global_position - global_position 
	
	velocity = playerDirection.normalized() * speed - knockBack
	
	if 	knockBack != Vector2.ZERO:
		knockBack = Vector2.ZERO

	move_and_slide()
	
	
func receiveDamage(damage):
	knockBack = -( global_position - Player.global_position) * damage
	
	health -= damage
	
	

func die():
	queue_free()
