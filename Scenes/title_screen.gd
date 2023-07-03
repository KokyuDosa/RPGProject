extends CanvasLayer




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$Sprite2D.hide()
	$NewGameButton.hide()
	
	# Remember to use the autoload name "Events" not the name of the script "events"
	Events.emit_signal("start_game")

