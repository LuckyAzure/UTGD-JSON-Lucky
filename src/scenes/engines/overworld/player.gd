extends CharacterBody2D

var forcestop = false

func _process(delta):
	if !forcestop:
		movement()
	animation(delta)

#-----------------------

const SPEED = 120
var walking = false
func movement():
	var direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
	)
	velocity = direction * SPEED
	move_and_slide()

#-----------------------

var frames = 0
var fps = 5
var prev_position = Vector2()
func animation(delta):
	if prev_position != position:
		prev_position = position
		frames += fps * delta
		if !walking:
			frames = 1
			walking = true
		$Frames.animation = get_animation_direction(velocity)
		$Frames.frame = int(frames) % 4
	else:
		if walking:
			walking = false
			$Frames.frame = 0

func get_animation_direction(velocity):
	if abs(velocity.x) > abs(velocity.y):
		return "Right" if velocity.x > 0 else "Left"
	else:
		return "Down" if velocity.y > 0 else "Up"

#-----------------------
