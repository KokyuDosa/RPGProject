extends Node

"""
Game Constants - START
"""
##### Tile size in pixels for the game.
const TILE_SIZE = 64
"""
Game Constants - END
"""


"""
Game State Variables - START
"""
##### PLAYER #####
# Player position on the loaded map, default to (0,0)
var player_pos: Vector2i = Vector2i.ZERO
# Player health parameters for hud
var player_max_health: int = 1
var player_current_health: int = 1

##### MAP STATE #####
# Conceivably I could refact this into:
# 1) A row-major 1d array representing the 2d coordinate system. This would be done in all functions
#    that initialize these values. A simple lookup and translation function could be implemented.
# 2) A single array where the entries are a dictionary of the values a tile position might have.
#    Potentially this could make saving and loading easier if it was all in dict format.

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
var map_size: Vector2i = Vector2i.ONE
# TODO: Alter map size to be a dict with level mapping to Vector2i size. Loaded from file at runtime
#       Such as -> map_size = {
#								"001": Vector2i(20,15)
#								"002": Vector2i(50,26)
#							  }


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
Array Initialization - START
"""
# Initialize all arrays to their respective default values
func initialize_arrays():
	for x in map_size.x:
		var visible_row = []
		var explored_row = []
		var transparent_row = []
		var occupiable_row = []
		
		for y in map_size.y:
			visible_row.push_back(false)
			explored_row.push_back(false)
			transparent_row.push_back(true)
			occupiable_row.push_back(true)
		
		visible_tiles.push_back(visible_row)
		explored_tiles.push_back(explored_row)
		transparent_tiles.push_back(transparent_row)
		occupiable_tiles.push_back(occupiable_row)


"""
Initializes a 2d array which keeps track of the state of whether a given tile is transparent for the
purposes of vision and field of view. The 2d array is the map size of a given level with x being the
width and y being the height. We first intialize the array to the be the proper size then grab the
tileset data for the level and set any non-transparent tiles to false.

This can then be referenced in the form of transparent_tiles[x][y] to get the transparency boolean
for usage with FOV and other necessary functions.

ARGS
tiles: the tilemap for the a level, should be included with every level
"""
func initialize_transparent_tiles(tiles) -> void:
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


func initialize_occupiable_tiles(tiles) -> void:
	# Set occupiable based on custom tile data.
	for x in map_size.x:
		for y in map_size.y:
			var tile_pos = Vector2i(x, y)
			var data = tiles.get_cell_tile_data(0, tile_pos)
			if data:
				occupiable_tiles[x][y] = data.get_custom_data("_transparent")
			else:
				print("Required custom tile data: '_transparent' not found.")
				break

"""
Array Initialization - END
"""

##### MOVEMENT #####
func try_move(dx, dy) -> void:
	var x = player_pos.x + dx
	var y = player_pos.y + dy


# Returns true if the provided coordinates are a location that the player can occupy.
func is_occupiable(x, y) -> bool:
	return occupiable_tiles[x][y]


func tile_to_pixel_center(x, y):
	return Vector2((x + 0.5) * TILE_SIZE, (y + 0.5) * TILE_SIZE)


func pixel_to_tile(pos: Vector2) -> Vector2:
	return floor(pos / Vector2(64,64))

##### ENTITY SPAWNING #####
"""
spawn_entity: takes the node which we are binding the provided entity as a child to, the position at
			  which to place the entity initially, and the group to which the entity is added to.

ARGS
cur_node: Node to spawn entity as child to
entity:   Entity to spawn
position: Position to spawn entity at, as an (x,y) position in tile coordiantes, not an absolute
		  pixel mapped position. Which is why we call tile_to_pixel_center()
group:	  The name of the group that this entity is being added to. Probably from a dictionary.
		  Use "none" if this entity is not being added to a group.
"""
func spawn_entity(cur_node, entity: PackedScene, position: Vector2, group: String) -> void:
	# Create new instance of entity from packed scene.
	var entity_to_spawn = entity.instantiate()
	
	# Add entity as child to provided scene, and set position of entity.
	cur_node.add_child(entity_to_spawn)
	entity_to_spawn.position = tile_to_pixel_center(position.x, position.y)
	
	# Add the entity to the provided group. Not added to any group if the provided arg is "none"
	if group != "none":
		entity_to_spawn.add_to_group(group)


