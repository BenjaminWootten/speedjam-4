extends Node2D

@onready var ray = $RayCast2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())

func get_ray_collision_point():
	return ray.get_collision_point()
