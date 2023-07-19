extends Area2D
class_name HitBoxComponent

@export var health_component: HealthComponent

func damage(attack: AttackComponent):
	if health_component:
		health_component.update_current_health(-attack.attack_damage)
		print("Attacking for: " + str(attack.attack_damage) + ", and " + str(health_component.current_health) + " left.")
