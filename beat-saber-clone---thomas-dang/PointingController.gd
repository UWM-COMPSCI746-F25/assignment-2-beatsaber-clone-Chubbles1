extends XRController3D

@export var saber_color: String = "red"

@onready var line_renderer =$LineRenderer
@onready var collision_shape = CollisionShape3D
@onready var audio_player = $AudioStreamPlayer3D

var is_saber_on = true

func _ready():
	line_renderer.set_process(false)
	if $Area3D.get_child_count()>0:
		collision_shape = $Area3D.get_child(0)
	audio_player.stream=load("res://819682__hotpin7__blaster-pew.wav")
	
func _process(_delta):
	line_renderer.visible = is_saber_on
	if is_saber_on:
		var origin = global_position
		var end = global_position - global_transform.basis.z
		line_renderer.points[0] = origin
		line_renderer.points[1] = end
		
		line_renderer._process(0.0)
	else:
		line_renderer.mesh.clear_surfaces()
		
func _on_area_3d_area_entered(area):
	if not is_saber_on:
		return
	
	var cube_node = area.get_parent()
	if cube_node.has_method("get_color") and cube_node.get_color() == saber_color:
		audio_player.play()
		cube_node.queue_free()


#Toggle Laser Visibility
func _on_button_pressed(button_name: String) -> void:
	if (button_name == "ax_button"):
		is_saber_on = not is_saber_on
		
		collision_shape.disabled = not is_saber_on
