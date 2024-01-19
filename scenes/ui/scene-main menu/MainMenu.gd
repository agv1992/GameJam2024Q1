extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$%PlayButton.pressed.connect(on_play_pressed)
	$%QuitButton.pressed.connect(on_quit_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/level/level test/LevelTest.tscn")
	

func on_quit_pressed():
	get_tree().quit()


# Called every input, then determined if it's useful or not
func _input(event):
	# Ensure that the key pressed, is in the Input Map
	if event is InputEventKey and event.pressed:
		# ENTER = Select Play button as default for quick selection
		if event.keycode == KEY_ENTER:
			on_play_pressed()

		# ESCAPE = need to say salutations before quitting the game
		elif event.keycode == KEY_ESCAPE:
			print("Goodbye!!!")
			on_quit_pressed()
