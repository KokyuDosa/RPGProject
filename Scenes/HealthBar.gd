extends ProgressBar

@export var healthcomponent: HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_value = healthcomponent.max_health
	self.value = healthcomponent.current_health
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = healthcomponent.get_current_health()

