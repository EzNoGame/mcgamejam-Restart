extends Node

const SAVE_FILE_PATH = "res://Save/save.save"
var data = {}
var file = File.new()

func _ready():
	load_data()

func save_data():
	file.open(SAVE_FILE_PATH, File.WRITE)
	file.store_var(data)
	file.close()
	
func load_data():
	if not file.file_exists(SAVE_FILE_PATH):
		data = {
			"techTreeUnlock":[],
			"resources":[],
		}
		save_data()
	file.open(SAVE_FILE_PATH, File.READ)
	data = file.get_var()
	file.close()
