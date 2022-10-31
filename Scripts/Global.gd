extends Node


const SAVE_PATH = "user://game_data.save"

var frog_list = [] setget set_frog_list, get_frog_list

const GAME_DATA = {
	"stage1" : {
		"camera_limit_right" : 0,
		"camera_limit_left" : 0,
		"total_frog" : 3,
	},
}

func get_frog_list():
	return frog_list

func set_frog_list(list):
	frog_list = list

func save_data():
	var file = File.new()
	file.open(SAVE_PATH,file.WRITE)
	file.close()

func load_data():
	var file = File.new()
	if file.file_exists(SAVE_PATH):
		file.open(SAVE_PATH,file.READ)
		file.close()
