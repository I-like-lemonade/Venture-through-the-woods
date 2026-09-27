extends CharacterBody2D


const SPEED = 150.0
const SPRINT_SPEED = 250.0

const JUMP_VELOCITY = -565.0
const SPRINT_JUMP_VELOCITY = -778.0

const GRAVITY_MULTIPLIER = 2.0
const RESPAWN_POSITION = Vector2(0, 0)
const DEATH_Y = 1000.0

var sprint_jump_locked := false
var sprint_jump_direction := 0.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * GRAVITY_MULTIPLIER * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():

		var jump_direction := Input.get_axis("ui_left", "ui_right")

		if Input.is_key_pressed(KEY_A):
			jump_direction = -1.0
		elif Input.is_key_pressed(KEY_D):
			jump_direction = 1.0

		if Input.is_key_pressed(KEY_SHIFT):
			velocity.y = SPRINT_JUMP_VELOCITY
			sprint_jump_locked = true
			sprint_jump_direction = jump_direction
		else:
			velocity.y = JUMP_VELOCITY
			sprint_jump_locked = false
	var direction := Input.get_axis("ui_left", "ui_right")

	if Input.is_key_pressed(KEY_A):
		direction = -1.0
	elif Input.is_key_pressed(KEY_D):
		direction = 1.0
	if not is_on_floor():

		if sprint_jump_locked:
			velocity.x = sprint_jump_direction * SPRINT_SPEED

		elif direction:
			velocity.x = move_toward(
				velocity.x,
				direction * SPEED,
				35.0
			)

	else:

		sprint_jump_locked = false
		sprint_jump_direction = 0.0

		if direction:

			if Input.is_key_pressed(KEY_SHIFT):
				velocity.x = direction * SPRINT_SPEED
			else:
				velocity.x = direction * SPEED

		else:
			velocity.x = move_toward(
				velocity.x,
				0,
				SPEED
			)

	move_and_slide()

	if global_position.y > DEATH_Y:
		global_position = RESPAWN_POSITION
		velocity = Vector2.ZERO
