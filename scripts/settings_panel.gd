extends Panel


func _on_tab_container_tab_changed(tab: int) -> void:
	$press.play()
	
func _on_button_pressed() -> void:
	$press.play()
	visible = false
	$"../MainPanel".visible = true
