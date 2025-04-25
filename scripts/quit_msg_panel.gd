extends Panel

func _on_yes_mouse_entered() -> void:
	$CryingElgato.visible = true
	$Elgato.visible = false
	
func _on_yes_pressed() -> void:
	$press.play()
	await get_tree().create_timer(0.2).timeout
	$Ehhhh.play()
	await get_tree().create_timer(2.4).timeout
	get_tree().quit()

func _on_no_mouse_entered() -> void:
	$CryingElgato.visible = false
	$Elgato.visible = true

func _on_no_pressed() -> void:
	$press.play()
	visible = false
	$"../MainPanel".visible = true
	await get_tree().create_timer(0.2).timeout
	$Yaaaaaaaaa.play()
