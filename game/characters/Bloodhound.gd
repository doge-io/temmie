extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var motion = Vector2()
onready var active = false
onready var ray = get_node("Ray")
onready var ray2 = get_node("Ray2")
onready var jump = get_node("/root/Level3/Jump")
const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 150 #slightly slower
const JUMP_HEIGHT = 450
func _physics_process(delta):
	motion.y += GRAVITY

	if ray.is_colliding() or ray2.is_colliding():
		$AnimatedSprite.play("Idle" if motion.x == 0 else "Walk")
	else:
		$AnimatedSprite.play("Fall")
		
	if active:
		if Input.is_action_pressed("ui_right"):
			motion.x = SPEED
			$AnimatedSprite.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
			$AnimatedSprite.flip_h = true
		else:
			motion.x = 0
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -JUMP_HEIGHT
				jump.play()
	else:
		motion.x = 0
		
	motion = move_and_slide(motion, UP)