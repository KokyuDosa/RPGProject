extends Node2D

@onready var tiles = $Level1TileMap

var initial_player_pos: Vector2 = Vector2(3,3)
const MAP_SIZE = Vector2i(25,15)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Pass initialization parameters to game manager
	GameLogic.player_pos = initial_player_pos
	GameLogic.map_size = MAP_SIZE
	GameLogic.initialize_transparent_tiles(tiles)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _input(event):
	if event.is_action_pressed("trackpadclick"):
		print_tile_info()
		var mouse_pos = get_global_mouse_position()
		var tile_position = tiles.local_to_map(mouse_pos)
		print("mouse click at: ", tile_position)
		
		print("\nTile Data:")
		print(GameLogic.transparent_tiles[tile_position.x][tile_position.y])
		


func print_tile_info():
	var clicked_cell = tiles.local_to_map(tiles.get_local_mouse_position())
	var data = tiles.get_cell_tile_data(0, clicked_cell)
	if data:
		print(data.get_custom_data("_tile_name"))
		print(data.get_custom_data("_transparent"))
		return data.get_custom_data("_tile_name")
	else:
		return 0
