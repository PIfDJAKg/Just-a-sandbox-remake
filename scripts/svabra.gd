extends Node3D

var is_woshing = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("LMB") and visible == true and !is_woshing and !GScript.UI_opened:
		is_woshing = true
		woshing()
		await get_tree().create_timer(0.01).timeout
		is_woshing = false

func woshing():
	if $RayCast3D.is_colliding():
		var target = $RayCast3D.get_collider()
		
		if target.has_method("woshing"):
			target.woshing()
			GScript.particles -= 1
			print(GScript.particles)
