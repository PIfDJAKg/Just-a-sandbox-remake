extends DirectionalLight3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shadow_enabled = SaveConfigScript.load_game_setings()["Shadows"]
