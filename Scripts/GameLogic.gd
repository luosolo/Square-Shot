extends Node


class_name GameLogic

export var speed = 300
export var life = 3
export var points = 0
export var level = 0

const enemy_point = 10

func reset():
	speed = 300
	life = 3
	points = 0
	level = 0

func _ready():
	reset()

func enemy_shot() -> bool:	
	points += enemy_point	
	if points % 100 == 0:		
		increase_level()
		return true
	return false

func isGameOver():
	return life <1 

func player_killed():
	life =max(0, life-1)
	

func increase_level():	
	level += 1
	speed += 50
