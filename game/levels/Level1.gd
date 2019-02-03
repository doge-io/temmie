extends Node

onready var players = [get_node("Corgi"),
					   get_node("Shiba"),
					   get_node("Bloodhound")]
					
onready var current_player_index = 0
onready var B_off = load("res://HUD/Bloodhound-Off.png")
onready var B_on = load("res://HUD/Bloodhound-On.png")
onready var C_off = load("res://HUD/Corgi-Off.png")
onready var C_on = load("res://HUD/Corgi-On.png")
onready var S_off = load("res://HUD/Shibe-Off.png")
onready var S_on = load("res://HUD/Shibe-On.png")
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _input(event):
	if event.is_action_pressed("ui_switch_left"):
		switch_character(true)
	elif event.is_action_pressed("ui_switch_right"):
		switch_character(false)
		
		
func switch_character(left):
	var current_player = players[current_player_index]
	current_player.active = false
	
	if current_player_index == 0:
		$CanvasLayer/HUD/Container/Corgi.texture = C_off
	elif current_player_index == 1:
		$CanvasLayer/HUD/Container/Shiba.texture = S_off
	elif current_player_index == 2:
		$CanvasLayer/HUD/Container/Bloodhound.texture = B_off
		
	current_player_index += -1 if left else 1
	if (current_player_index < 0):
		current_player_index = len(players)-1
	elif current_player_index > len(players)-1:
		current_player_index = 0
	current_player = players[current_player_index]
	current_player.active = true
	current_player.get_node("Camera2D").current = true
	
	if current_player_index == 0:
		$CanvasLayer/HUD/Container/Corgi.texture = C_on
	elif current_player_index == 1:
		$CanvasLayer/HUD/Container/Shiba.texture = S_on
	elif current_player_index == 2:
		$CanvasLayer/HUD/Container/Bloodhound.texture = B_on
	
func _process(delta):
	for player in players:
		if player.position.y > 1000:
			get_tree().reload_current_scene()