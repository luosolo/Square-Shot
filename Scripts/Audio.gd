extends Node2D


onready var player = $player
const laser_sound = preload("res://assets/music/laser.ogg")

func laser():
	player.stream = laser_sound
	player.play()
	
func boom():
	#player.stream = explosion_sound
	#player.play()
	pass
	
	
	
