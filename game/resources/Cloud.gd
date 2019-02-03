extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var sprite = get_node("CloudSprite")
onready var effect = get_node("Effect")
func _ready():
	effect.interpolate_property(sprite, 'modulate',
        Color(1, 1, 1, 1), Color(1, 1, 1, 0), 10,
        Tween.TRANS_LINEAR, Tween.EASE_IN)
	effect.start()

func _on_Effect_tween_completed(object, key):
	queue_free()