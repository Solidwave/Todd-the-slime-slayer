extends Node2D


@export var width = 2000
@export var height = 2000
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
	fastNoise.noise_type = FastNoiseLite.TYPE_PERLIN
	fastNoise.frequency = frequency
	
	fastNoise.fractal_type = FastNoiseLite.FRACTAL_FBM
	fastNoise.fractal_octaves = octaves
	
	var grid = {
	}
	
	for x in width:
		for y in height:
			var rand = fastNoise.get_noise_2d(x,y)
			grid[Vector2(x,y)] = rand
	return grid
	
func _ready():
	temperature = generate_map(0.01,5)
	
	set_tile(width,height)
	
func set_tile(width, height):
	for x in width:
		for y in height:
			var pos = Vector2(x,y)
#			var alt = altitude[pos]
#			var moist = moisture[pos]
			var temp = temperature[pos]
			var terrain = get_terrain_set(temp)
			tile_map.set_cells_terrain_connect(0,[pos],terrain[0], terrain[1])
				
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
		
