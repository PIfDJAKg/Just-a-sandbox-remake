extends Node

var out_game_dir = DirAccess.open("user://maps")

func _ready() -> void:
	_searching_maps_out_game()
	
func _searching_maps_out_game(): #поиск файлов карт в файлах игры
	if out_game_dir:
		out_game_dir.list_dir_begin() #пролистывание директории
		var file_name = out_game_dir.get_next() #выбор следующего файла и запись в переменную
		while file_name != "": #начало цикла
			print(file_name)
			if ".pck" in file_name:
				var map_success = ProjectSettings.load_resource_pack("user://maps/" + file_name)
				if map_success:
					print("success")
			file_name = out_game_dir.get_next() #выбор следующего файла и запись в переменную
		out_game_dir.list_dir_end() #окончание пролистывания
		
