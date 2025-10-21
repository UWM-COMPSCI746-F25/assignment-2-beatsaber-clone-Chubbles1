extends Node3D

var xr_interface: XRInterface
var cube_spawner: Node3D

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
		xr_interface.connect("pose_recentered",_on_pose_recentered)
	else:
		print("OpenXR not initialized, please check if your headset is connected")
	
	cube_spawner = $CubeSpawner

func _on_pose_recentered():
	var cubes = cube_spawner.get_children()
	
	if cubes.is_empty():
		return
	
	var last_cube = cubes.back()
	var head = $XROrigin3D/XRCamera3D
	
	$XROrigin3D.look_at(last_cube.global_position,Vector3.UP)
	
	var origin_offset = head.global_position - $XROrigin3D.global_position
	$XROrigin3D.global_position = -origin_offset
	$XROrigin3D.global_position.x = last_cube.global_position.x
	$XROrigin3D.global_position.y = last_cube.global_position.y
