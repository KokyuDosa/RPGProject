extends Node2D
class_name DamageReceiverComponent

@export var healthcomponent: HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.health_update.connect(apply_damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func apply_damage(damage_amt: int) -> void:
	healthcomponent.update_current_health(damage_amt)
	
