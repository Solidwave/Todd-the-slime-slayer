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
	ocean =  {
		0.8 : Vector2i(0,2),
		0.9 : Vector2i(1,2),
		1 : Vector2i(2,2),
	},
	grass = {
		0.8 : Vector2i(0,0),
		0.9 : Vector2i(1,0),
		1 : Vector2i(2,0),
	},
	desert =  {
		0.8 : Vector2i(0,1),
		0.9 : Vector2i(1,1),
		1 : Vector2i(2,1),
	}
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
				tile_map.set_cell(0,pos, 0, getTile(biomes.ocean) )
			elif alt < 0.3:
				tile_map.set_cell(0,pos, 0,  getTile(biomes.desert))
			else:
				tile_map.set_cell(0,pos, 0,  getTile(biomes.grass))
			
				
#			#Ocean
#			if 	alt < 0.2:
#				tilemap.set_cell(0,pos,0,biomes.ocean)
#			if	alt >= 0.2:
#				if moist < 0.3:
#					tilemap.set_cell(0,pos,0,biomes.desert)
#				else:
#					tilemap.set_cell(0,pos,0,biomes.grass)

#func _input(event):
#	if event is InputEventScreenTouch:
#		get_tree().reload_current_scene()
		
func getTile(biome: Dictionary) -> Vector2i:
	var rand = randf()
	
	for key in biome.keys():
		if rand <= key:
			return biome[key]
	return Vector2i(0,0)		
