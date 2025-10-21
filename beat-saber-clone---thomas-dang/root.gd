extends Node3D

var xr_interface: XRInterface
var cube_spawner: Node3D
var left_controller: XRController3D

func _ready():
	# Get a reference to the right controller as soon as the scene is ready.
	left_controller = $XROrigin3D/Left
	
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		get_viewport().use_xr = true
		
		# Connect directly to the controller's button press signal.
		# This is the most reliable method.
		left_controller.button_pressed.connect(_on_left_controller_button_pressed)
	else:
		print("OpenXR not initialized, please check if your headset is connected")
	
# This function is called every time any button is pressed on the right controller.
func _on_left_controller_button_pressed(button_name):
	# We check if the button that was pressed is the "menu_button".
	if button_name == "menu_button":
		XRServer.center_on_hmd(XRServer.RESET_BUT_KEEP_TILT, true)
