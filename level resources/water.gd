extends Area2D

const RISE_ACCELERATION=0.0001
var rise_speed = 0.1

func _process(_delta):
	rise_speed += RISE_ACCELERATION
	position.y -= rise_speed
