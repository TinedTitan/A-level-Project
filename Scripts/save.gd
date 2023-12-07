extends Node

const savefile = "UserData://SAVEFILE.save"

var game_data = {}

func _ready():
	load_data()
	print(game_data)
	
func load_data():
	if not FileAccess.file_exists("UserData://SAVEFILE.save"):
		game_data = {
			"fullscreen" : true,
			"vsync" : false,
			"screen_height" : 1920,
			"screen_width" : 1080,
		}
		save_data()
	var file = FileAccess.open(savefile, FileAccess.READ)
	game_data = file.get_var()
	file.close()
	
func save_data():
	var file = FileAccess.open(savefile, FileAccess.WRITE)
	file.store_var(game_data)
	file.close()
	

