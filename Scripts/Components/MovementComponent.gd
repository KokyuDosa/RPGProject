extends Node2D
class_name MovementComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	print("MovementComponent Entered Scene")
	Events.position_update.connect(position_transform)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# Need to 


func try_move(position_delta: Vector2i):
	return 1
	#add logic to check if new movement is valid
	
func position_transform(position_delta):
	return 1
	#add logic to update the position of the entity
