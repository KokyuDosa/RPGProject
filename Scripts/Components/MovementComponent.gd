extends Node2D
class_name MovementComponent

@export var current_pos: Vector2i

# Needs the sprite so i can flip_h it
@export var character_sprite: Sprite2D



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
	
	if determine_collision(x, y):
		return false
	
	if position_delta.x < 0 and !character_sprite.flip_h :
		character_sprite.flip_h = true
	elif position_delta.x > 0 and character_sprite.flip_h:
		character_sprite.flip_h = false
	
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


"""
determine_collision

This function takes in the new location that the entity is attempting to move into and returns
true if there is a collidable object in this location, false if not.
"""
func determine_collision(new_x: int, new_y: int) -> bool:
	print("Entered determine collision")
	var space_state = get_world_2d().direct_space_state
	
	# The PhysicsRayQueryParameters2D.create creates the parameters to be sent to an intersect_ray
	# function call. The third parameter in the create() is the bitmask for the collidable objects.
	# I should probably change this to an enum for which objects to check for since I can use bit
	# addition to simply say something like ENEMY + WALL and the collision detection will check for
	# that. Additionally I could dictate the collision parameters based on equipment or abilities.
	var query = PhysicsRayQueryParameters2D.create(
		GameLogic.tile_to_pixel_center(current_pos.x, current_pos.y), GameLogic.tile_to_pixel_center(new_x,new_y), 2
		)
	var result = space_state.intersect_ray(query)
	print(query)
	if result.is_empty():
		
		return false
	else:
		return true

func position_transform(position_delta):
	if try_move(position_delta):
		get_parent().position = (current_pos * GameLogic.TILE_SIZE) + (Vector2i.ONE*GameLogic.TILE_SIZE/2)
