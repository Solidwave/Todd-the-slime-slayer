extends Node2D

@onready var tile_map = $TileMap

@export var width = 600
@export var height = 600
@onready var ocean = $Ocean

var bush = preload("res://bush.tscn")

var temperature = {}
var altitude = {}
var moisture = {}
var biome = {}

var fastNoise = FastNoiseLite.new()

var grassBiome : PackedVector2Array

var oceanTexture : Texture = preload("res://TerrainTextures/ocean_texture.tres")

var oceanBiome : Dictionary = {}

var is_ocean = func(item) -> bool:
	return item.value <= 0.5
	
var dirtArray : Array[Vector2i] = []
var grassArray : Array[Vector2i] = []
var waterArray : Array[Vector2i] = []

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

func generate_map(frequency, octave):
	randomize()
	fastNoise.seed = randi()
	fastNoise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	fastNoise.frequency = frequency
	
	fastNoise.fractal_type = FastNoiseLite.FRACTAL_FBM
	
	var grid = {
	}
	
	for x in width:
		for y in height:
			var rand = 2 * abs(fastNoise.get_noise_2d(x,y))
			
			grid[Vector2i(x,y)] = rand
	return grid

#func _draw():
#	for ocean in oceanBiome:
#		draw_colored_polygon(Geometry2D.convex_hull(oceanBiome[ocean]),Color.RED)
func _ready():
	altitude = generate_map(0.01,5)	
	
#	generate_biomes(altitude)
	
	set_tiles()
	
	spawn_objects()
#	queue_redraw()

	
#func generate_biomes(grid):
#	var oceanIndex = 0
#	for x in grid:
#		var alt = grid[x].value
#		if	alt <= 0.5:
#			var adiacent = is_adiacent_same_type(x, is_ocean,grid)
#			if	adiacent != -1:
#				oceanBiome[adiacent].append(Vector2i(x.x,x.y))
#				grid[x].index = adiacent 
#			else:
#				oceanBiome[oceanIndex] = PackedVector2Array([x])
#				grid[x].index = oceanIndex
#				oceanIndex += 1
		
		
func set_tiles():
	for x in altitude:
		var alt = altitude[x]
#		if 	alt < 0.2:
#			waterArray.append(x)
		if alt < 0.3:
			dirtArray.append(x)
		else:
			grassArray.append(x)
	tile_map.set_cells_terrain_connect(1,dirtArray,0,0, false)
	tile_map.set_cells_terrain_connect(0,grassArray,0,1, false)

func spawn_objects():
	for x in grassArray:
		if randf() < 0.1:
			var position = tile_map.map_to_local(x)
			
			var bush_object = bush.instantiate()
			
			
			bush_object.global_position = position 
			
			add_child(bush_object)
				
			
			
	
	
#	tile_map.set_cells_terrain_connect(1,waterArray,0,2)
func is_adiacent_same_type(pos : Vector2i,check, grid : Dictionary ) -> int:
	var up = Vector2i(pos.x, pos.y-1)
	var left = Vector2i(pos.x-1, pos.y)
	
	if grid.has(up):
		return grid[up].index
	if grid.has(left):
		return grid[left].index
	return -1
	
#
	
	
	

#func _input(event):
#	if event is InputEventScreenTouch:
#		get_tree().reload_current_scene()
		
func getTile(biome: Dictionary) -> Vector2i:
	var rand = randf()
	
	for key in biome.keys():
		if rand <= key:
			return biome[key]
	return Vector2i(0,0)		
