extends Area2D


enum DIRECTION { UP, DOWN, LEFT, RIGHT} 
var direction = DIRECTION.UP
export var speed = 250

func _ready():
	pass # Replace with function body.


func change_direction(dir):
	direction = dir
	if (dir == DIRECTION.UP):
		rotate(0)
	elif (dir == DIRECTION.RIGHT):
		rotate(deg2rad(90))
	elif (dir == DIRECTION.DOWN):
		rotate(deg2rad(180))
	elif (dir == DIRECTION.LEFT):
		rotate(deg2rad(270))
		
		
func shoted():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == DIRECTION.UP:
		position.y -=speed*delta
	elif direction == DIRECTION.DOWN:
		position.y +=speed*delta
	elif direction == DIRECTION.LEFT:
		position.x -=speed*delta
	elif direction == DIRECTION.RIGHT:
		position.x +=speed*delta
		
	if position.x < 8 or position.x >180 or position.y<12 or position.y >180:
		print("removing bullet")
		queue_free()
		
