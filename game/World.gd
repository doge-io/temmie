extends Node

onready var player1 = get_node("/root/World/Corgi")
onready var player2 = get_node("/root/World/Shiba")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _input(event):
  if event.is_action_pressed("ui_select"):
    # Just an ugly boolean switch :D
    player1.active = !player1.active
    player2.active = !player2.active