extends Label

@onready var scorekeeper = Scorekeeper

func _process(delta):
	if scorekeeper.timer_on:
		scorekeeper.time += delta
		
		var milisecs = fmod(scorekeeper.time, 1) * 1000
		var secs = fmod(scorekeeper.time, 60)
		var mins = fmod(scorekeeper.time, 60*60) / 60
		
		var time_passed = "%02d : %02d : %03d" % [mins, secs, milisecs]
		text = time_passed
