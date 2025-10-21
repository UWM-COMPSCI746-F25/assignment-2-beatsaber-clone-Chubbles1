extends Node3D

var xr_interface: XRInterface
var cube_spawner: Node3D
var right_controller: XRController3D

func _ready():
	# Get a reference to the right controller as soon as the scene is ready.
	right_controller = $XROrigin3D/Right
	
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		get_viewport().use_xr = true
		
		# Connect directly to the controller's button press signal.
		# This is the most reliable method.
		right_controller.button_pressed.connect(_on_right_controller_button_pressed)
	else:
		print("OpenXR not initialized, please check if your headset is connected")
	
	cube_spawner = $CubeSpawner

# This function is called every time any button is pressed on the right controller.
func _on_right_controller_button_pressed(button_name):
	# We check if the button that was pressed is the "menu_button".
	if button_name == "trigger_click":
		XRServer.center_on_hmd(XRServer.RESET_BUT_KEEP_TILT, true)
"""
		var cubes = cube_spawner.get_children()
		if not cubes.is_empty():
			var last_cube = cubes.back()
			# Use call_deferred to run the reorientation logic on the next idle frame.
			# This avoids conflicts with the XR server's tracking updates.
			call_deferred("_recenter_to_cube", last_cube)

# This function now accepts the cube as an argument so it can be called deferred.
func _recenter_to_cube(cube_to_face):
	print("Menu button pressed, recentering to cube!")
	
	var head = $XROrigin3D/XRCamera3D
	
	# This part remains the same: it finds the cube and snaps the view to it.
	$XROrigin3D.look_at(cube_to_face.global_position, Vector3.UP)
	
	var origin_offset = head.global_position - $XROrigin3D.global_position
	$XROrigin3D.global_position = -origin_offset
	$XROrigin3D.global_position.x = cube_to_face.global_position.x
	$XROrigin3D.global_position.y = cube_to_face.global_position.y
"""
