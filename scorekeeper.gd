extends Node

const SAVE_PATH = "user://times.save"

var time = 0
var timer_on = false

class Score:
	var name: String
	var score: String

var game_data = {
	"scores" : [],
	"level" : 1
}

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(game_data)

func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		file.get_var(game_data)

