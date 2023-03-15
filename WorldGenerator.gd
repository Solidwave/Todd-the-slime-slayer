extends Node2D


@export var width = 600
@export var height = 200
@onready var tile_map = $TileMap

var temperature = {}
var altitude = {}
var moisture = {}
var biome = {}

var fastNoise = FastNoiseLite.new()

var biomes = {
	ocean = Vector2(7,12),
	grass = Vector2(2,20),
	desert = Vector2(9,22)
}

func generate_map(frequency, octaves):
	randomize()
	fastNoise.seed = randi()
	fastNoise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	fastNoise.frequency = frequency
	
	fastNoise.fractal_type = FastNoiseLite.FRACTAL_FBM
	fastNoise.fractal_octaves = octaves
	
	var grid = {
	}
	
	for x in width:
		for y in height:
			var rand = 2 * abs(fastNoise.get_noise_2d(x,y))
			
			grid[Vector2(x,y)] = rand
	return grid
	
func _ready():
	temperature = generate_map(0.01,5)
	altitude = generate_map(0.01,5)
	moisture = generate_map(0.02,5)
	
	
	set_tile(width,height)
	
func set_tile(width, height):
	for x in width:
		for y in height:
			var pos = Vector2(x,y)
			
			var temp = temperature[pos]
			
			var alt = altitude[pos]
			
			var mois = moisture[pos]
			
			print(alt)
			
			if	alt < 0.1:
				tile_map.set_cell(0,pos, 1, biomes.ocean)
			elif alt < 0.3:
				tile_map.set_cell(0,pos, 1, biomes.desert)
			else:
				tile_map.set_cell(0,pos, 1, biomes.grass)
			
				
#			#Ocean
#			if 	alt < 0.2:
#				tilemap.set_cell(0,pos,0,biomes.ocean)
#			if	alt >= 0.2:
#				if moist < 0.3:
#					tilemap.set_cell(0,pos,0,biomes.desert)
#				else:
#					tilemap.set_cell(0,pos,0,biomes.grass)

func get_terrain_set(rand):
	if rand < -0.1:
		return [0,0]
	if rand < 0.4:
		return [0,1]
	return [1,1]
	
func _input(event):
	if event is InputEventScreenTouch:
		get_tree().reload_current_scene()
		
