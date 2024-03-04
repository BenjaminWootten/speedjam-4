extends Control

@onready var scorekeeper = Scorekeeper

func _ready():
	var data = scorekeeper.load_data()
	$MarginContainer/VBoxContainer/MarginContainer2/time1.text = data[0].formatted_time
	$MarginContainer/VBoxContainer/MarginContainer3/time2.text = data[1].formatted_time
	$MarginContainer/VBoxContainer/MarginContainer4/time3.text = data[2].formatted_time
	$MarginContainer/VBoxContainer/MarginContainer5/time4.text = data[3].formatted_time
	$MarginContainer/VBoxContainer/MarginContainer6/time5.text = data[4].formatted_time


func _on_button_pressed():
	get_tree().change_scene_to_file("res://UI/mainMenu.tscn")
