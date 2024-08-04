extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -200.0
const MAX_JUMP_TIME = 0.25  # Maximum time to hold jump for increased height
const JUMP_FORCE_MULTIPLIER = 1.5  # Multiplier for jump force when holding jump

var jump_pressed_time = 0.0
var gravity = 980

func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_pressed("Up"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_pressed_time = 0.0
		else:
			jump_pressed_time += delta
			if jump_pressed_time < MAX_JUMP_TIME:
				velocity.y -= gravity * JUMP_FORCE_MULTIPLIER * delta
	if !Input.is_action_pressed("Up") and !is_on_floor():
		jump_pressed_time = MAX_JUMP_TIME


	if Input.is_action_just_released("Up") and velocity.y < 0:
		# Cap the upward velocity when the jump button is released mid-jump.
		velocity.y = max(velocity.y, -100)

	# Get the input direction and handle the movement/deceleration.
	var direction = 0
	if Input.is_action_pressed("Left"):
		direction = -1
	elif Input.is_action_pressed("Right"):
		direction = 1

	if Input.is_action_pressed("Cancel"):
		direction *= 0.5

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
