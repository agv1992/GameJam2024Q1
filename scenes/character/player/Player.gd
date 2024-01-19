extends CharacterBody2D

const GRAVITY = 500
const MAX_X_VELOCITY = 200
const JUMP_VELOCITY = 300
@export var max_jump_count : int

var jump_count : int
var velocity_x_before_collision = 0

signal damage_taken

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO
	max_jump_count = 2
	jump_count = 0
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	store_previous_velocity()
	_determine_movement_vector(delta)
	_update_animation()
	move_and_slide()


func _determine_movement_vector(delta):
	velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("Move Left") and abs(velocity.x) <= MAX_X_VELOCITY:
		velocity.x += -700 * delta
	elif Input.is_action_just_pressed("Move Right") and abs(velocity.x) <= MAX_X_VELOCITY:
		velocity.x += 700 * delta
	elif Input.is_action_pressed("Move Left") and abs(velocity.x) <= MAX_X_VELOCITY:
		velocity.x += -500 * delta
	elif Input.is_action_pressed("Move Right") and abs(velocity.x) <= MAX_X_VELOCITY:
		velocity.x += 500 * delta
		
	# This is the velocity change for when someone is stopping
	elif velocity.x >= 25:
		velocity.x -= 750 * delta
	elif velocity.x < -25:
		velocity.x += 750 * delta
	else:
		velocity = Vector2(0, velocity.y)
	
	if is_on_wall_only():
		velocity.y = 10
		jump_count = 0
	
	if is_on_floor():
		jump_count = 0	
		
	if Input.is_action_just_pressed("Jump"):
		jump()


func _update_animation():
	if abs(velocity.x) > 1:
		$AnimatedSprite2D.flip_h = false if velocity.x > 0 else true


func store_previous_velocity():
	if velocity.x != 0:
		velocity_x_before_collision= velocity.x


func jump():
	if jump_count < max_jump_count:
		jump_count += 1
		
		if is_on_wall():
			if velocity_x_before_collision > 0:
				velocity.x = -250
			else:
				velocity.x = 250
		velocity.y = -1 * JUMP_VELOCITY
		
