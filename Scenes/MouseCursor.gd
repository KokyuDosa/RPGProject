extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position() + Vector2(32, 0)
	position.x = (floor(mouse_pos.x/64) * GameLogic.TILE_SIZE)
	position.y = (floor(mouse_pos.y/64) * GameLogic.TILE_SIZE) + 32
	
