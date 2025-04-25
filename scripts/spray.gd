extends Node3D

var is_paint = false
var spray_point = preload("res://scenes/other/spray_point.tscn")

func _process(delta: float) -> void:
	if $GPUParticles3D.draw_pass_1.material.albedo_color != GScript.painting_color:
		$GPUParticles3D.draw_pass_1.material.albedo_color = GScript.painting_color
	if Input.is_action_pressed("LMB") and visible == true and !is_paint and !GScript.UI_opened:
		is_paint = true
		paint()
		await get_tree().create_timer(0.04).timeout
		is_paint = false
		if !$AudioStreamPlayer3D.playing:
			$AudioStreamPlayer3D.play()
		$GPUParticles3D.emitting = true
	else:
		$GPUParticles3D.emitting = false

func paint():
	if $RayCast3D.is_colliding():
		var collide_point = $RayCast3D.get_collision_point()
		var normal = $RayCast3D.get_collision_normal()
		var target = $RayCast3D.get_collider()
		
		GScript.particles += 1

		if !target.has_method("shoot_hit"):
			var point = spray_point.instantiate()
			get_tree().current_scene.add_child(point)  # Сначала добавляем объект в сцену
			var child = point.get_child(0)
			var material = StandardMaterial3D.new()  # Создайте новый экземпляр материала
			var texture = preload("res://textures/spray_point.png")  # Загрузите текстуру
			material.albedo_texture = texture  # Назначьте текстуру в качестве albedo_texture
			material.transparency = StandardMaterial3D.TRANSPARENCY_ALPHA
			material.albedo_color = GScript.painting_color
			child.set_surface_override_material(0, material)
			child.sorting_offset = float(GScript.particles * 0.001)
			point.scale = Vector3(GScript.Paint_size, GScript.Paint_size, GScript.Paint_size)
			point.global_position = collide_point  # Теперь можно установить global_position
			point.look_at(collide_point + normal, Vector3.UP)
			point.look_at(collide_point + normal, Vector3.RIGHT)
		elif target.has_method("shoot_hit"):
			var point = spray_point.instantiate()
			target.add_child(point)  # Сначала добавляем объект в сцену
			var child = point.get_child(0)
			var material = StandardMaterial3D.new()  # Создайте новый экземпляр материала
			var texture = preload("res://textures/spray_point.png")  # Загрузите текстуру
			material.albedo_texture = texture  # Назначьте текстуру в качестве albedo_texture
			material.transparency = StandardMaterial3D.TRANSPARENCY_ALPHA
			material.albedo_color = GScript.painting_color
			child.set_surface_override_material(0, material)
			child.sorting_offset = float(GScript.particles * 0.001)
			point.scale = Vector3(GScript.Paint_size, GScript.Paint_size, GScript.Paint_size)
			point.global_position = collide_point  # Теперь можно установить global_position
			point.look_at(collide_point + normal, Vector3.UP)
			point.look_at(collide_point + normal, Vector3.RIGHT)
