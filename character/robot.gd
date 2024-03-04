extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var grapple = $grapple

const MAX_SPEED = 400.0
const ACCELERATION = 20.0
const DECELERATION = 50.0
const JUMP_VELOCITY = -600.0
const GRAPPLE_VELOCITY = 0.99
@onready var START_POSITION = position

var grappling = false
var grapple_point
var grapple_length

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("grapple"):
		# If grappling ray collides, initiate grapple
		var collision = grapple.get_ray_collision_point()
		velocity.y += 1
		if collision:
			grappling = true
			grapple_point = collision
			grapple_length = global_position.distance_to(grapple_point)
	
	if Input.is_action_just_released("grapple"):
		grappling = false
		grapple.release_grapple()
	
	if grappling:
		swing(delta)
		velocity *= GRAPPLE_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	# Check if there is a direction, velocity is below max
	if direction and (not(sign(velocity.x) and sign(direction)) or sign(velocity.x) == sign(direction)):
		if velocity.x * direction < MAX_SPEED:
			velocity.x += direction * ACCELERATION
			# Handle sprite animation
			sprite.play("walk")
			if direction == 1:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
	elif grappling == false:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		sprite.play("default")
	
	move_and_slide()

func swing(delta):
	var radius = global_position - grapple_point
	if radius.length() > 30 and velocity.length() > 0.01:
		var angle = acos(radius.dot(velocity) / (radius.length() * velocity.length()))
		var rad_vel = cos(angle) * velocity.length()
		velocity += radius.normalized() * -rad_vel
		
		if global_position.distance_to(grapple_point) > grapple_length:
			global_position = grapple_point + radius.normalized() * grapple_length
		
		velocity += (grapple_point - global_position).normalized() * 15000 * delta
	else:
		velocity = Vector2(0,0)


func _on_rising_water_body_entered(body):
	position = START_POSITION
	velocity = Vector2.ZERO


func _on_static_body_2d_body_entered(body):
	pass


func _on_static_body_2d_2_body_entered(body):
	pass # Replace with function body.
