extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var motion = Vector2()
onready var active = false

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = 400
func _physics_process(delta):
	motion.y += GRAVITY
	if active:
		if Input.is_action_pressed("ui_right"):
			motion.x = SPEED
		elif Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
		else:
			motion.x = 0
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -JUMP_HEIGHT
	else:
		motion.x = 0
		
	motion = move_and_slide(motion, UP)