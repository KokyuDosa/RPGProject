extends Resource

@export var max_hp: int = 1


var current_hp:int = 1

func _init(hp: int = 1):
	max_hp = hp
	current_hp = hp
