extends Node2D
class_name HealthComponent

@export var max_health: float
@export var current_health: float

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_health()
	#Events.health_update.connect(update_current_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func update_current_health(health_delta):
	current_health = max(0, min(current_health + health_delta, max_health))
	if get_parent().get_name() == "Player":
		GameLogic.player_current_health = current_health
		
	if current_health <= 0:
		death()

func get_current_health():
	return current_health

func initialize_health(health_val: int = 30):
	max_health = health_val
	current_health = max_health

# Player death handling will probably require it's own component since this is a roguelite style
# where information needs to be saved upon death and action handling needs to be passed to another
# gui, as well as saving player data for story based reinstantiation.
func death():
	get_parent().queue_free()
