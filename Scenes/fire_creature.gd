extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent


func _ready():
	health_component.initialize_health()
	



func _on_hit_box_component_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("trackpadclick"):
		var attack = AttackComponent.new()
		$HitBoxComponent.damage(attack)
