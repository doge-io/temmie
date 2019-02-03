extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = 400
const CLOUD_TIMER = 9

var motion = Vector2()
var double_jumped = false
var cloudObj = null
var cloud = null
onready var active = false
onready var cloud_created = false
onready var ray = get_node("Ray")
onready var ray2 = get_node("Ray2")
onready var jump = get_node("/root/Level3/Jump")
onready var fart = get_node("/root/Level3/Fart")
var timer = null
func _ready():
	cloudObj = load("res://resources/Cloud.tscn")
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(CLOUD_TIMER)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
	set_collision_mask_bit(1, false)
	
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
		
		if Input.is_action_just_pressed("ui_up"):
			if is_on_floor():
				motion.y = -JUMP_HEIGHT
				jump.play()
				double_jumped = false
			elif not double_jumped:
				motion.y = -JUMP_HEIGHT
				if fart:
					fart.play()
				double_jumped = true
				
				if cloud_created:
					get_parent().remove_child(cloud)
				spawn_cloud()
	else:
		motion.x = 0
	
	motion = move_and_slide(motion, UP)

func on_timeout_complete():
	cloud.remove_child(cloud.get_child(0))
	
	
func spawn_cloud():
	cloud = cloudObj.instance()
	cloud.position = get_position()
	cloud.position.y += 36
	get_parent().add_child(cloud)
	cloud_created = true
	timer.start()
	