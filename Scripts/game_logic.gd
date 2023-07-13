extends Node

var TILE_SIZE = 64


"""
Game State Variables - START
"""
##### PLAYER #####
# Player position on the loaded map, default to (0,0)
var player_pos: Vector2i = Vector2i.ZERO

##### MAP STATE #####
# Each of the three following variables is instantiated as a 2d array representing the current level
# map. Entries are from (0, 0) and include Z(nonneg), the set of non-negative integers. A map will
# never have tiles at a position below (0, 0). The entries for these 2d array entries are booleans.
var visible_tiles: Array = []		# True if tile is visible
var explored_tiles: Array = []		# True if tile is explored
var transparent_tiles: Array = []	# True if tile is transparent

var occupiable_tiles: Array = []	# True if the tile can be occupied by an entity

# Default map size of 1x1, always initialized to real map size for a given level. Should be set when
# a level enters the scene tree. Setting in this way should only occur when the player shifts to a
# new level.
var map_size: Vector2 = Vector2.ONE


"""
Game State Variables - END
"""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

"""
Initializes a 2d array which keeps track of the state of whether a given tile is transparent for the
purposes of vision and field of view. The 2d array is the map size of a given level with x being the
width and y being the height. We first intialize the array to the be the proper size then grab the
tileset data for the level and set any non-transparent tiles to false.

This can then be referenced in the form of transparent_tiles[x][y] to get the transparency boolean
for usage with FOV and other necessary functions.
"""
func initialize_transparent_tiles(tiles):
	# Initialize 2d array to true
	for x in map_size.x:
		var transparent_row = []
		
		for y in map_size.y:
			transparent_row.push_back(true)
		
		transparent_tiles.push_back(transparent_row)
	
	# Set transparency based on custom tile data.
	for x in map_size.x:
		for y in map_size.y:
			var tile_pos = Vector2i(x, y)
			var data = tiles.get_cell_tile_data(0, tile_pos)
			if data:
				transparent_tiles[x][y] = data.get_custom_data("_transparent")
			else:
				print("Required custom tile data: '_transparent' not found.")
				break



##### MOVEMENT #####
func try_move(dx, dy) -> void:
	var x = player_pos.x + dx
	var y = player_pos.y + dy
	



# Returns true if the provided coordinates are a location that the player can occupy.
func is_occupiable(x, y) -> bool:
	
	return true




func tile_to_pixel_center(x, y):
	return Vector2((x + 0.5) * TILE_SIZE, (y + 0.5) * TILE_SIZE)
