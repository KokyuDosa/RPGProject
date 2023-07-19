extends Node2D
class_name MovementComponent

@export var current_pos: Vector2i



# Called when the node enters the scene tree for the first time.
func _ready():
	Events.position_update.connect(position_transform)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_current_position(pos: Vector2i) -> void:
	current_pos = pos
	
func get_current_position() -> Vector2i:
	return current_pos


func try_move(position_delta: Vector2i):
	var x = current_pos.x + position_delta.x
	var y = current_pos.y + position_delta.y
	
	if position_delta.x < 0 and !get_parent().flip_h :
		get_parent().flip_h = true
	elif position_delta.x > 0 and get_parent().flip_h:
		get_parent().flip_h = false
	
	# Check if tile to be moved into is occupiable.
	if GameLogic.occupiable_tiles[x][y]:
		# Set tile being moved out of to false and tile being moved in to to true
		GameLogic.occupiable_tiles[current_pos.x][current_pos.y] = true
		GameLogic.occupiable_tiles[x][y] = false
		
		# Update current position to tile entity is trying to move into
		current_pos = Vector2i(x, y)
		# Special case where if this attached to the player then we update the player position in
		# in the global game variables. Probably not necessary with some refactoring.
		if get_parent().name == "Player":
			GameLogic.player_pos = Vector2i(x, y)
		return true
	else:
		return false


func position_transform(position_delta):
	if try_move(position_delta):
		get_parent().position = (current_pos * GameLogic.TILE_SIZE) + (Vector2i.ONE*GameLogic.TILE_SIZE/2)
