extends Node2D


var instance:GameLogic
onready var lives = $LIFE
onready var points = $POINT
onready var option = $Option
onready var options = [$"Option/NEW GAME",$"Option/QUIT"]

onready var ne = $"Option/NEW GAME"
var selected = 0

signal new_game

func addInstance(ist):
	instance = ist
	refreshInfo()
	
func new_game():
	option.visible = false

func game_over():
	option.visible = true
	
func _input(event):
	if option.visible:
		if event.is_action_pressed("ui_up"):
			var current = options[selected]
			current.add_color_override("font_color", Color(1, 1, 1))
			selected = (selected -1 )% 2		
			options[selected].add_color_override("font_color", Color(1, 0, 0))
		elif event.is_action_pressed("ui_down"):
			var current = options[selected]
			current.add_color_override("font_color", Color(1, 1, 1))
			selected = (selected +1 )% 2		
			options[selected].add_color_override("font_color", Color(1, 0, 0))
		elif event.is_action_pressed("ui_accept"):
			if selected == 0:		
				emit_signal("new_game")
				new_game()
			else:
				get_tree().quit()
		
	
func refreshInfo():
	lives.text = "LIFE: "+str(instance.life)
	points.text = "POINTS: "+str(instance.points)
