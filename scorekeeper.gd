extends Node

const SAVE_PATH = "user://times.save"

var time = 0
var timer_on = false
var player_name = ""

func format_time(time_to_format):
	var milisecs = fmod(time_to_format, 1) * 1000
	var secs = fmod(time_to_format, 60)
	var mins = fmod(time_to_format, 60*60) / 60
	
	var time_passed = "%02d : %02d : %03d" % [mins, secs, milisecs]
	return time_passed

class Score:
	@export var name: String = ""
	@export var time: int = 1000000
	@export var formatted_time: String = ""

var scores = [Score.new(), Score.new(), Score.new(), Score.new(), Score.new()]

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(scores)

func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		return file.get_var(true)

func save_score():
	timer_on = false
	var score = Score.new()
	score.name = player_name
	score.time = time
	score.formatted_time = format_time(score.time)
	
	var i = 0
	for high_score in scores:
		if score.time < high_score.time:
			scores.insert(i, score)
			save_data()
			break
		i+=1
