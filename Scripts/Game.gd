extends Node2D
enum DIRECTION { UP, DOWN, LEFT, RIGHT} 

const enemyClass = preload("res://Scenes/Enemy.tscn")
const bulletClass= preload("res://Scenes/Bullet.tscn")
onready var player = $Player
onready var timer = $Timer
onready var game_ui = $GAME_UI
var rng = RandomNumberGenerator.new()
var start_speed = 300

onready var audio = $Audio
var gameInstanceObject = GameLogic.new() 
var inGame = true


var enemyPos= {
	DIRECTION.UP : Vector2(373,745),
	DIRECTION.DOWN : Vector2(373,10),
	DIRECTION.LEFT : Vector2(750,382),
	DIRECTION.RIGHT : Vector2(10,382),
}

func _ready():
	rng.randomize()	
	player.connect("player_killed", self, "_on_player_killed")	
	game_ui.addInstance(gameInstanceObject)
	game_ui.connect("new_game", self, "_on_new_game")
	gameInstanceObject.reset()
	game_ui.game_over()
	game_over()
	
func _on_new_game():
	gameInstanceObject.reset()
	game_ui.refreshInfo()
	inGame = true
	player.game_over = false
	timer.wait_time = 0.8
	
	
func shot(dir):
	var instance = bulletClass.instance()
	instance.change_direction(dir)
	instance.z_index=2
	instance.position = player.position
	audio.laser()
	add_child(instance)

func _input(event):
	if inGame:
		if event.is_action_pressed("ui_up"):
			shot(DIRECTION.UP)		
		elif event.is_action_pressed("ui_right"):
			shot(DIRECTION.RIGHT)
		elif event.is_action_pressed("ui_down"):
			shot(DIRECTION.DOWN)
		elif event.is_action_pressed("ui_left"):
			shot(DIRECTION.LEFT)


func add_enemy(dir):	
	var instance = enemyClass.instance()
	instance.scale = Vector2(1.5,1.5)
	instance.position = enemyPos[dir]
	instance.direction = dir
	instance.speed = gameInstanceObject.speed
	instance.connect("ennemy_destroyed", self, "_on_ennemy_destroyed")
	
	self.add_child(instance)
	
func _on_ennemy_destroyed () :
	if (gameInstanceObject.enemy_shot()):
		timer.wait_time -= 0.1
	game_ui.refreshInfo()
	
func _on_player_killed () :
	gameInstanceObject.player_killed()
	game_ui.refreshInfo()
	if gameInstanceObject.isGameOver():		
		game_over()	
	
func game_over():
	inGame = false	
	player.game_over = true
	game_ui.game_over()
		

func _on_Timer_timeout():
	if inGame:
		var dir = rng.randi_range(0,3)	
		add_enemy(dir)
