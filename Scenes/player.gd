extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func initial_position():
	position = (GameLogic.player_pos * GameLogic.TILE_SIZE) + (Vector2i.ONE*GameLogic.TILE_SIZE/2) 
