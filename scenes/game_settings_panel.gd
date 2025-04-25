extends Panel

func _ready() -> void:
	var Settings_values = SaveConfigScript.load_game_setings()
	$"V-Sync".button_pressed = Settings_values["V-Sync"]
	$Window.button_pressed = Settings_values["Fullscreen"]
	$Language.selected = Settings_values["Language"]
	$Mouse_Sensitivity.value = Settings_values["Mouse Sensitivity"]
	$FOV.value = Settings_values["Fov"]
	$Brightness.value = Settings_values["Brightness"]
	$Shadows3.button_pressed = Settings_values["Shadows"]
	$"FPS-Visibility".button_pressed = Settings_values["FPS-Visibility"]
	
	$Mouse_Sensitivity/Label2.text = str(Settings_values["Mouse Sensitivity"])
	$FOV/Label2.text = str(Settings_values["Fov"])
	$Brightness/Label2.text = str(Settings_values["Brightness"])

	
func _on_v_sync_toggled(toggled_on: bool) -> void:
	SaveConfigScript.save_game_settings("V-Sync", toggled_on)


func _on_window_toggled(toggled_on: bool) -> void:
	SaveConfigScript.save_game_settings("Fullscreen", toggled_on)
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func _on_language_item_selected(index: int) -> void:
	SaveConfigScript.save_game_settings("Language", index)


func _on_mouse_sensitivity_value_changed(value: float) -> void:
	SaveConfigScript.save_game_settings("Mouse Sensitivity", int(value))
	$Mouse_Sensitivity/Label2.text = str(int(value))


func _on_fov_value_changed(value: float) -> void:
	SaveConfigScript.save_game_settings("Fov", int(value))
	$FOV/Label2.text = str(int(value))

func _on_brightness_value_changed(value: float) -> void:
	SaveConfigScript.save_game_settings("Brightness", int(value))
	$Brightness/Label2.text = str(int(value))

func _on_shadows_3_toggled(toggled_on: bool) -> void:
	SaveConfigScript.save_game_settings("Shadows", toggled_on)


func _on_fps_visibility_toggled(toggled_on: bool) -> void:
	SaveConfigScript.save_game_settings("FPS-Visibility", toggled_on)
