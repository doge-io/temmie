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
var cloudObj = null
var cloud = null
onready var active = false
onready var cloud_created = false
func _ready():
	cloudObj = load("res://Cloud.tscn")
func _physics_process(delta):
	motion.y += GRAVITY
	if active:
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
				
				if cloud_created:
					get_parent().remove_child(cloud)
				cloud = cloudObj.instance()
				cloud.position = get_position()
				cloud.position.y += 16
				get_node("/root/Level1").add_child(cloud)
				cloud_created = true
				
				
	else:
		motion.x = 0
	
	motion = move_and_slide(motion, UP)