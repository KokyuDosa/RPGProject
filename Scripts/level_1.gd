extends Node2D

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_scene = load("res://Scenes/player.tscn")
	player = player_scene.instantiate()
	add_child(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
