extends Camera2D

var target_position = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 5)) 


func acquire_target():
	# The player character is the only node in the "player" group.
	var sprite_nodes = get_tree().get_nodes_in_group("player")
	if sprite_nodes.size() > 0:
		# This is assigning the first node in the "player" group to a local variable
		#     that the camera will have access to. If the notion of having only
		#     one player in the "player" group, revisit.
		var player_sprite = sprite_nodes[0] as Node2D
		target_position = player_sprite.global_position
