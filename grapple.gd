extends Node2D

@onready var ray = $RayCast2D

var moveable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moveable:
		look_at(get_global_mouse_position())

func get_ray_collision_point():
	if not ray.is_colliding(): return
	var collision = ray.get_collision_point()
	if collision:
		moveable = false
	return collision

func release_grapple():
	moveable = true
