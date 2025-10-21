extends Node3D

# The color of this cube
const CUBE_COLOR = "blue"

# Speed at which the cube moves towards the player
@export var speed = 4.0

# This function is required by the assignment for color matching
func get_color():
	return CUBE_COLOR

func _process(delta):
	# Move the cube forward (positive Z direction) towards the player
	global_position.z += speed * delta
	
	# --- This is the new logic for destroying the cube if it passes the player ---
	# If the cube's Z position is greater than 1, it's behind the player.
	if global_position.z > 1.0:
		queue_free() # Remove the cube from the scene
