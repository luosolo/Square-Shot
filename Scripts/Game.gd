extends Node2D
enum DIRECTION { UP, DOWN, LEFT, RIGHT} 

const enemyClass = preload("res://Scenes/Enemy.tscn")
const bulletClass= preload("res://Scenes/Bullet.tscn")
onready var player = $Player
var rng = RandomNumberGenerator.new()


var enemyPos= {
	DIRECTION.UP : Vector2(93,180),
	DIRECTION.DOWN : Vector2(93,25),
	DIRECTION.LEFT : Vector2(169,97),
	DIRECTION.RIGHT : Vector2(21,97),
}

func _ready():
	rng.randomize()
	
func shot(dir):
	var instance = bulletClass.instance()
	instance.change_direction(dir)
	instance.z_index=2
	instance.position = player.position
	add_child(instance)

func _input(event):
	if event.is_action_pressed("ui_up"):
		shot(DIRECTION.UP)
	elif event.is_action_pressed("ui_right"):
		shot(DIRECTION.RIGHT)
	elif event.is_action_pressed("ui_down"):
		shot(DIRECTION.DOWN)
	elif event.is_action_pressed("ui_left"):
		shot(DIRECTION.LEFT)


func add_enemy(dir):
	print("add enemy ", dir)
	var instance = enemyClass.instance()
	instance.position = enemyPos[dir]
	instance.direction = dir
	self.add_child(instance)
		

func _on_Timer_timeout():
	var dir = rng.randi_range(0,3)
	add_enemy(dir)
