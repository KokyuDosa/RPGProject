extends CanvasLayer


var simultaneous_scene = preload("res://Scenes/level_1.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	
	
	$Sprite2D.hide()
	$NewGameButton.hide()
	add_sibling(simultaneous_scene)
	print("added level 1")
	get_tree().get_root().print_tree_pretty()
	
	# Remember to use the autoload name "Events" not the name of the script "events"
	Events.emit_signal("start_game")

