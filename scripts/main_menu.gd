extends Control

func _on_stats_btn_pressed() -> void:
	$MainPanel/press.play()
	
func _on_quit_btn_pressed() -> void:
	$MainPanel/press.play()
	$MainPanel.visible = false
	$QuitMsgPanel.visible = true
	
func _on_settings_btn_pressed() -> void:
	$MainPanel/press.play()
	$MainPanel.visible = false
	$SettingsPanel.visible = true

func _on_play_btn_pressed() -> void:
	$MainPanel/press.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/test_scene.tscn")

func _ready() -> void:
	var Fullscreen = SaveConfigScript.load_game_setings()["Fullscreen"]
	if Fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and $SettingsPanel.visible == true:
		$MainPanel.visible = true
		$SettingsPanel.visible = false
	elif Input.is_action_just_pressed("ui_cancel") and $QuitMsgPanel.visible == true:
		$MainPanel.visible = true
		$QuitMsgPanel.visible = false
