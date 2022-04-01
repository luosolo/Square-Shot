extends Area2D


enum DIRECTION { UP, DOWN, LEFT, RIGHT} 
var direction = DIRECTION.UP
export var speed = 100

func _process(delta):
	if direction == DIRECTION.UP:
		position.y -=speed*delta
	elif direction == DIRECTION.DOWN:
		position.y +=speed*delta
	elif direction == DIRECTION.LEFT:
		position.x -=speed*delta
	elif direction == DIRECTION.RIGHT:
		position.x +=speed*delta


func destroy_complete():
	pass


func _on_Enemy_area_entered(area):
	if area.get_collision_layer() ==2:
		area.shoted()
		queue_free()
