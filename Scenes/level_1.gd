extends Node2D

@onready var tiles = $Level1TileMap

var initial_player_pos: Vector2 = Vector2(3,3)
const MAP_SIZE = Vector2i(25,15)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Pass initialization parameters to game manager
	GameLogic.player_pos = initial_player_pos
	GameLogic.map_size = MAP_SIZE
	GameLogic.initialize_arrays()
	GameLogic.initialize_transparent_tiles(tiles)
	GameLogic.initialize_occupiable_tiles(tiles)
	
	
	var player_scene = load("res://Scenes/player.tscn").instantiate()
	player_scene.initial_position()

	add_child(player_scene)
	player_scene.health_component.initialize_health(250)

	
	var mob = load("res://Scenes/fire_creature.tscn")
	

	for i in range(1,3):
		var entity_pos = Vector2(i+1,i)
		GameLogic.spawn_entity(self, load("res://Scenes/fire_creature.tscn"), entity_pos, "enemies")
		#GameLogic.occupiable_tiles[i+1][i] = false
	
#	var mult = 1
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		print(enemy.health_component.get_current_health())
		print(GameLogic.pixel_to_tile(enemy.position))
		

	#print(get_tree().get_nodes_in_group("enemies"))
	
	# Idiom for checking if a child scene has the function I want to use.
	# In this case we're initializing the position of the player in the player node. I'm not sure
	# if there is a way to do this with some sort of constructor since apparently _init() doesn't
	# act as an object constructor?
	var player_children = player_scene.get_children()
	for player_child in player_children:
		if player_child.has_method("set_current_position"):
			player_child.set_current_position(initial_player_pos)




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
		
	elif event.is_action_pressed("move_down"):
		Events.emit_signal("position_update", Vector2i(0,1))
	elif event.is_action_pressed("move_up"):
		Events.emit_signal("position_update", Vector2i(0,-1))
	elif event.is_action_pressed("move_left"):
		Events.emit_signal("position_update", Vector2i(-1,0))
	elif event.is_action_pressed("move_right"):
		Events.emit_signal("position_update", Vector2i(1,0))


func print_tile_info():
	var clicked_cell = tiles.local_to_map(tiles.get_local_mouse_position())
	var data = tiles.get_cell_tile_data(0, clicked_cell)
	if data:
		print(data.get_custom_data("_tile_name"))
		print(data.get_custom_data("_transparent"))
		return data.get_custom_data("_tile_name")
	else:
		return 0
