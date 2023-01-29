extends Node2D


@export var width = 600
@export var height = 200
@onready var tilemap = $TileMap

var temperature = {}
var altitude = {}
var moisture = {}
var biome = {}

var fastNoise = FastNoiseLite.new()

var biomes = {
	ocean = Vector2(22,14),
	grass = Vector2(0,25),
	desert = Vector2(9,22)
}

func generate_map(frequency, octaves):
	fastNoise.seed = randi()
	fastNoise.noise_type = FastNoiseLite.TYPE_PERLIN
	
	var grid = {
	}
	
	for x in width:
		for y in height:
			var rand = 2*(abs(fastNoise.get_noise_2d(x,y)))
			grid[Vector2(x,y)] = rand
	return grid
	
func _ready():
	temperature = generate_map(300,5)
	moisture = generate_map(300,5)
	altitude = generate_map(150,5)
	set_tile(width,height)
	
func set_tile(width, height):
	for x in width:
		for y in height:
			var pos = Vector2(x,y)
			var alt = altitude[pos]
			var moist = moisture[pos]
			var temp = temperature[pos]
			
			#Ocean
			if 	alt < 0.2:
				tilemap.set_cell(0,pos,0,biomes.ocean)
			if	alt >= 0.2:
				if moist < 0.3:
					tilemap.set_cell(0,pos,0,biomes.desert)
				else:
					tilemap.set_cell(0,pos,0,biomes.grass)
				
func _input(event):
	if event is InputEventScreenTouch:
		get_tree().reload_current_scene()
		
