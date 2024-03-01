extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const MAX_SPEED = 800.0
const ACCELERATION = 20.0
const DECELERATION = 50.0
const JUMP_VELOCITY = -600.0

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
		pass
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	# Check if there is a direction, velocity is below max
	if direction and velocity.x * direction < MAX_SPEED and (not(sign(velocity.x) and sign(direction)) or sign(velocity.x) == sign(direction)):
		velocity.x += direction * ACCELERATION
		# Handle sprite direction
		if direction == 1:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
	
	move_and_slide()
