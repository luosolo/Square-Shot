extends Area2D



onready var sprite = $Player_Sprite

func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("ui_up"):
		sprite.frame = 0
	elif event.is_action_pressed("ui_right"):
		sprite.frame = 1
	elif event.is_action_pressed("ui_down"):
		sprite.frame = 2
	elif event.is_action_pressed("ui_left"):
		sprite.frame = 3


func _on_Player_area_entered(area):
	if (area.get_collision_layer() ==1):
		print("GAME OVER")
