extends Node3D

var red_cube = preload("res://red_cube.tscn")
var blue_cube = preload("res://blue_cube.tscn")

@onready var timer = $Timer

func _ready() -> void:
	_reset_timer()
	
func _spawn_cube():
	var new_cube
	if randf() >0.5:
		new_cube = red_cube.instantiate()
	else:
		new_cube = blue_cube.instantiate()
	
	var spawn_x = randf_range(-1.5,1.5)
	var spawn_y = randf_range(1.0,2.0)
	var spawn_z = -15.0
	
	new_cube.global_position = Vector3(spawn_x,spawn_y,spawn_z)
	add_child(new_cube)

func _reset_timer():
	timer.wait_time = randf_range(0.5, 2.0)
	timer.start()

func _on_timer_timeout():
	_spawn_cube()
	_reset_timer()
	
