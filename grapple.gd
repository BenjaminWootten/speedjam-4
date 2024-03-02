extends Node2D

@onready var ray = $RayCast2D
@onready var target = $target
@onready var line = $Line2D
@onready var hook_sprite = $hook
@onready var animation_player = $AnimationPlayer

const MAX_RAY_LENGTH = 400
const ANIMATION_SPEED = 10

var moveable = true
var target_position

func _process(delta):
	if moveable:
		# Animate hook to return to player
		hook_sprite.global_position.x = move_toward(hook_sprite.global_position.x, self.global_position.x, ANIMATION_SPEED)
		hook_sprite.global_position.y = move_toward(hook_sprite.global_position.y, self.global_position.y, ANIMATION_SPEED)
		
		var mouse = get_global_mouse_position()
		look_at(mouse)
		# Change ray target position to mouse position unless past max length
		if self.global_position.distance_to(mouse) < MAX_RAY_LENGTH:
			ray.target_position.y = self.global_position.distance_to(mouse)/2
		
		# Move target to ray collision point
		if ray.is_colliding():
			target.global_position = ray.get_collision_point()
		# Move target to mouse when not colliding
		elif self.global_position.distance_to(mouse) < MAX_RAY_LENGTH:
			target.global_position = mouse
	# Move target to grapple point when grappling
	else:
		target.global_position = target_position
		# Animate hook to target
		hook_sprite.global_position.x = move_toward(hook_sprite.global_position.x, target_position.x, ANIMATION_SPEED)
		hook_sprite.global_position.y = move_toward(hook_sprite.global_position.y, target_position.y, ANIMATION_SPEED)
	
	# Update line
	line.points[1] = hook_sprite.position

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
