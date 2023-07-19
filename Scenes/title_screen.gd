extends CanvasLayer


var simultaneous_scene = preload("res://Scenes/level_1.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	$TitleImage.hide()
	$NewGameButton.hide()
	add_sibling(simultaneous_scene)

	
	#var player_pos = simultaneous_scene.initial_player_pos
	#var player_scene = load("res://Scenes/player.tscn").instantiate()
	#add_sibling(player_scene)
	
	get_tree().get_root().print_tree_pretty()
	
	
	
	# Remember to use the autoload name "Events" not the name of the script "events"
	Events.emit_signal("start_game")

