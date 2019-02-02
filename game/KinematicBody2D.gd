extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = 400

var motion = Vector2()
var double_jumped = false
func _physics_process(delta):
	motion.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			motion.y = -JUMP_HEIGHT
			double_jumped = false
		elif not double_jumped:
			motion.y = -JUMP_HEIGHT
			double_jumped = true
	
	motion = move_and_slide(motion, UP)