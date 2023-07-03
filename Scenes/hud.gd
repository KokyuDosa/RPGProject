extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.start_game.connect(show_hud)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_hud():
	"""When you need to pause for a brief time, an alternative to using a Timer
	node is to use the SceneTree's create_timer() function.
	This can be very useful to add delays such as in the above code, where we
	want to wait some time before showing the "Start" button"""
	# await get_tree().create_timer(1.0).timeout
	$HPValue.show()
	$HP.show()
	
func hide_hud():
	$HPValue.hide()
	$HP.hide()
