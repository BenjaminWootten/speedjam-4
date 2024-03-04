extends Label

@onready var scorekeeper = Scorekeeper

func _process(delta):
	if scorekeeper.timer_on:
		scorekeeper.time += delta
		text = scorekeeper.format_time(scorekeeper.time)
