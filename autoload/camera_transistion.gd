extends Node

var transitioning = false	# Used to ensure transition_camera2D() won't run if a transition is already in progress
@onready var transition_camera : Camera2D = $Camera2D	# This is the 3rd (global) camera to assist the zoom transition


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Called when user InputEventKey is pressed to toggle between player cam and world cam, or vice versa
func transition_camera2D(from: Camera2D, to: Camera2D, duration: float = 1.0) -> void:
	if transitioning: return	# Function doesn't need to run if a transition is already in progress (user spams InputEventKey)
	
	var tween = get_tree().create_tween()	# Used for smooth transition path between the two Camera2D nodes
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	# Copy parameters of the first cam (from) to the transition camera
	transition_camera.zoom = from.zoom
	transition_camera.offset = from.offset
	transition_camera.light_mask = from.light_mask
	
	# Move transistion cam to the first cam's position (from)
	transition_camera.global_transform = from.global_transform
	
	# Start useing the transition cam. This will be what moves along the path between the original two cams
	transition_camera.make_current()
	
	transitioning = true	# Keep track of the transition process now that the transition cam is in use
	
	# Smoothly transition the transition cam to the opposite cameras location
	# Useing all the parameters we copied from the first cam above. 
	tween.set_parallel(true)	# Transition all params at the same time (alternatively can insert ".parallel()" after "tween" for each)
	tween.tween_property(transition_camera, "global_transform", to.global_transform, duration)
	tween.tween_property(transition_camera, "zoom", to.zoom, duration)
	tween.tween_property(transition_camera, "offset", to.offset, duration)

	# Wait for the tween to complete
	await tween.finished	# await replaced yield in 4.x

	# Now the transition cam has reached it's destination. Make the second cam the current one
	to.make_current()
	
	transitioning = false	# Keep track of the transition process closure now that the second cam is in use
