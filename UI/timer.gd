extends Label

var time = 0

func _process(delta):
	time += delta
	
	var milisecs = fmod(time, 1) * 1000
	var secs = fmod(time, 60)
	var mins = fmod(time, 60*60) / 60
	
	var time_passed = "%02d : %02d : %03d" % [mins, secs, milisecs]
	text = time_passed
