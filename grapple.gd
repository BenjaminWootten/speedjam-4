extends Node2D

@onready var ray = $RayCast2D
@onready var target = $target

const MAX_RAY_LENGTH = 400

var moveable = true
var target_position

func _process(delta):
	# Rotate and move target
	if moveable:
		var mouse = get_global_mouse_position()
		look_at(mouse)
		print(ray.target_position)
		if self.global_position.distance_to(mouse) < MAX_RAY_LENGTH:
			ray.target_position.y = self.global_position.distance_to(mouse)/2
		
		if ray.is_colliding():
			target.global_position = ray.get_collision_point()
		elif self.global_position.distance_to(mouse) < MAX_RAY_LENGTH:
			target.global_position = mouse
	else:
		target.global_position = target_position

func get_ray_collision_point():
	# Return nothing if not colliding
	if not ray.is_colliding(): return
	
	# Return collision point, lock target
	var collision = ray.get_collision_point()
	target_position = collision
	moveable = false
	return collision

func release_grapple():
	moveable = true
