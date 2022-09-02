extends Node2D


var instance:GameLogic
onready var lives = $LIFE
onready var points = $POINT
onready var option = $Option
onready var options = [$"Option/NEW GAME",$"Option/Credits",$"Option/QUIT"]

onready var score = $"Option/Score"
var selected = 0

signal new_game

func _ready():
	score.visible = false

func addInstance(ist):
	instance = ist
	refreshInfo()
	
func new_game():
	option.visible = false
	score.visible = true

func game_over(score_value):	
	option.visible = true
	if score_value>=0:
		score.text = "Your Score is "+str(score_value)
	
func _input(event):
	if option.visible:
		if event.is_action_pressed("ui_up"):
			var current = options[selected]
			current.add_color_override("font_color", Color(1, 1, 1))
			selected = (selected -1 )% 3	
			options[selected].add_color_override("font_color", Color(1, 0, 0))
		elif event.is_action_pressed("ui_down"):
			var current = options[selected]
			current.add_color_override("font_color", Color(1, 1, 1))
			selected = (selected +1 )% 3		
			options[selected].add_color_override("font_color", Color(1, 0, 0))
		elif event.is_action_pressed("ui_accept"):
			if selected == 0:		
				emit_signal("new_game")
				new_game()
			elif selected ==1:
				get_tree().change_scene("res://Scenes/Credits.tscn")
			else:
				get_tree().quit()
		
	
func refreshInfo():
	lives.text = "LIFE: "+str(instance.life)
	points.text = "POINTS: "+str(instance.points)
