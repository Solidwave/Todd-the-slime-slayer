extends CharacterBody2D

@export var speed = 100

@export var health = 100



@onready var enemiesSprite : Sprite2D = $Enemies

var knockBack: Vector2 = Vector2.ZERO;

func _ready():
	var rnd = RandomNumberGenerator.new()
	
	rnd.randomize()
	
	enemiesSprite.frame = rnd.randi_range(0,2)
func _physics_process(delta):
	if	health <= 0:
		die()
		
	
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
