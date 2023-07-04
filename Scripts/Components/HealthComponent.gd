extends Node2D
class_name HealthComponent

@export var max_health: float

var current_health: float

# Called when the node enters the scene tree for the first time.
func _ready():
	print("HealthComponent Entered Scene")
	initialize_health()
	Events.health_update.connect(update_current_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update_current_health(health_delta):
	current_health = max(0, min(current_health + health_delta, max_health))
	
func get_current_health():
	return current_health

func initialize_health():
	current_health = max_health
