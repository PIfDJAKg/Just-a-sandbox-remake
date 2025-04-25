extends Node

var config = ConfigFile.new()
var SETTINGS_FILE_PATH = "user://settings.ini"

func _ready() -> void:
	print(OS.get_user_data_dir())
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("game", "V-Sync", true)
		config.set_value("game", "Fullscreen", true)
		config.set_value("game", "Language", 0)
		config.set_value("game", "Mouse Sensitivity", 50)
		config.set_value("game", "Shadows", true)
		config.set_value("game", "FPS-Visibility", false)
		config.set_value("game", "Fov", 60)
		config.set_value("game", "Brightness", 50)
		
		config.set_value("keybinding", "forward_move", "W")
		config.set_value("keybinding", "backward_move", "S")
		config.set_value("keybinding", "left_move", "A")
		config.set_value("keybinding", "right_move", "D")
		config.set_value("keybinding", "spawn_object", "Q")
		
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)

func save_game_settings(key:String, value):
	config.set_value("game", key, value)
	config.save(SETTINGS_FILE_PATH)
	
func load_game_setings():
	var video_settings = {}
	for key in config.get_section_keys("game"):
		video_settings[key] = config.get_value("game", key)
	return video_settings
	
func save_keybinding_settings(key:String, value):
	config.set_value("game", key, value)
	config.save(SETTINGS_FILE_PATH)
		
func load_keybinding_setings():
	var keybinding_settings = {}
	for key in config.get_section_keys("keybinding"):
		keybinding_settings[key] = config.get_value("keybinding", key)
	return keybinding_settings
	
