extends Node

var particles = 0
var last_particles = 0
var UI_opened = false
var painting_color:Color = Color("#ffffff")
var Paint_size = 0.6
var player_dir = preload("res://scenes/player.tscn")

func  _process(delta: float) -> void:
	if particles > last_particles:
		print(particles)
		last_particles = particles

func spawn(object):
	add_child(object)

func VsyncSet() -> void:
	var settings_values = SaveConfigScript.load_game_setings()
	if settings_values["V-Sync"] == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
