extends Node


const SAVE_PATH = "user://game_data.save"

const GAME_DATA = {
	"stage1" : {
		"camera_limit_right" : 0,
		"camera_limit_left" : 0,
		"total_frog" : 3,
	},
}




func save_data():
	var file = File.new()
	file.open(SAVE_PATH,file.WRITE)
	file.close()

func load_data():
	var file = File.new()
	if file.file_exists(SAVE_PATH):
		file.open(SAVE_PATH,file.READ)
		file.close()
