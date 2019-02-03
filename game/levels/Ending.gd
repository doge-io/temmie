extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var corgi = get_node("Corgi")
onready var effect = get_node("Tween")
var timer = null
var stage = 0
var kid_textures = null
func _ready():
	get_tree().get_root().set_disable_input(true)
	effect.interpolate_property(corgi, 'translate',
        corgi.position, Vector2(227, 296), 3,
        Tween.TRANS_LINEAR, Tween.EASE_IN)
	effect.start()
	corgi.get_child(0).play("Walk")
	timer = Timer.new()
	timer.set_wait_time(3)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
	kid_textures = [load("res://sprites/ending-kid0001.png"), load("res://sprites/ending-kid0002.png")]

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func on_timeout_complete():
	
	if stage < 2:
		$BG/Kid.texture = kid_textures[stage]
		stage += 1
		timer.start()
		$EndSprite.position = Vector2(277, 189)
	else:
		get_tree().get_root().set_disable_input(false)
		get_tree().change_scene("res://scenes/TitleScreen.tscn")
		
func _on_Tween_tween_completed(object, key):
	corgi.get_child(0).play("Idle")
	timer.start()
