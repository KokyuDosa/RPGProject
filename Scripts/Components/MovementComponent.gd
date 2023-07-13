extends Node2D
class_name MovementComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.position_update.connect(position_transform)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func try_move(position_delta: Vector2i):
	var x = GameLogic.player_pos.x + position_delta.x
	var y = GameLogic.player_pos.y + position_delta.y
	
	if position_delta.x < 0:
		if not get_parent().flip_h:
			get_parent().flip_h = true
	elif get_parent().flip_h:
		get_parent().flip_h = false
	
	if GameLogic.occupiable_tiles[x][y]:
		GameLogic.player_pos = Vector2i(x, y)
		return true
	else:
		return false


func position_transform(position_delta):
	if try_move(position_delta):
		get_parent().position = (GameLogic.player_pos * GameLogic.TILE_SIZE) + (Vector2i.ONE*GameLogic.TILE_SIZE/2)
