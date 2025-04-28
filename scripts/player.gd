extends CharacterBody3D

@export var SPEED := 5.5
@export var JUMP_VELOCITY := 4.5
@export var mouse_sensitivity := 0.1
@export var gravity := 12 
@export var MASS_KG = 80.0

var jumps = 2
var jump_on_wall = false

var Sprint = false

@onready var camera_pivot := $cam
@onready var camera := $cam/Camera3D

@onready var fresh_light: SpotLight3D = $cam/Fresh_Light

func _ready():
	GScript.VsyncSet()
	var Settings_values = SaveConfigScript.load_game_setings()
	$cam/Camera3D.fov = int(Settings_values["Fov"])
	print(Settings_values)
	$UI/FPS_LABEL_COUNTER.visible = Settings_values["FPS-Visibility"]
	mouse_sensitivity = float(Settings_values["Mouse Sensitivity"]) / 500
	$cam/Camera3D.attributes.exposure_multiplier = float(Settings_values["Brightness"]) / 50
	# Захват мыши
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func  _process(delta: float) -> void:
	if global_position.y < -90:
		global_position = Vector3(0, 30, 0)
		$Audio/Mr_FishAudio.play()
	
	if Input.is_action_just_pressed("f"):
		fresh_light.visible = not fresh_light.visible

func _input(event):
	# Управление камерой мышью
	if event is InputEventMouseMotion and !GScript.UI_opened:
		# Горизонтальный поворот персонажа
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
	
		# Вертикальный поворот камеры
		camera_pivot.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		camera_pivot.rotation.x = clamp(
			camera_pivot.rotation.x,
			deg_to_rad(-90),  # Ограничение угла обзора
			deg_to_rad(90)   # чтобы камера не переворачивалась
		)
		
func push_away_rigid_bodies(): #взято с ютуба
	for i in get_slide_collision_count():
		var c := get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			var push_dir = -c.get_normal()
			# How much velocity the object needs to increase to match player velocity in the push direction
			var velocity_diff_in_push_dir = self.velocity.dot(push_dir) - c.get_collider().linear_velocity.dot(push_dir)
			# Only count velocity towards push dir, away from character
			velocity_diff_in_push_dir = max(0., velocity_diff_in_push_dir)
			# Objects with more mass than us should be harder to push. But doesn't really make sense to push faster than we are going
			var mass_ratio = min(1., MASS_KG / c.get_collider().mass)
			# Optional add: Don't push object at all if it's 4x heavier or more
			if mass_ratio < 0.25:
				continue
			# Don't push object from above/below
			push_dir.y = 0
			# 5.0 is a magic number, adjust to your needs
			var push_force = mass_ratio * 5.0
			c.get_collider().apply_impulse(push_dir * velocity_diff_in_push_dir * push_force, c.get_position() - c.get_collider().global_position)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ctrl"):
		if Sprint:
			SPEED -= 2.5
		else:
			SPEED += 2.5
		
		Sprint = not Sprint
	
	if is_on_floor() and jumps < 2:
		jumps = 2
	elif is_on_wall() and jumps == 0 and not jump_on_wall:
		jump_on_wall = true
		jumps = 1
  
	if not is_on_wall() and jump_on_wall:
		jump_on_wall = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if jumps > 0:
			velocity.y = JUMP_VELOCITY
			jumps -= 1
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and !GScript.UI_opened:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	push_away_rigid_bodies()
	move_and_slide()
