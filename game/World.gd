extends Node

onready var players = [get_node("/root/Level1/Corgi"),
					   get_node("/root/Level1/Shiba"),
					   get_node("/root/Level1/Bloodhound")]
					
onready var current_player_index = 0
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _input(event):
	if event.is_action_pressed("ui_select"):
    # Just an ugly boolean switch :D
		print(players[current_player_index])
		players[current_player_index].active = false
		current_player_index = 0 if current_player_index >= len(players)-1 else current_player_index + 1
		players[current_player_index].active = true
		
		