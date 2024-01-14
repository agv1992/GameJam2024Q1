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
