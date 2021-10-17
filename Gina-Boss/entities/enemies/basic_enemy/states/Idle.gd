extends "res://entities/enemies/basic_enemy/states/AbstractBasicEnemyState.gd"

onready var timer: Timer = $IdleTimer
export var max_wait: int = 5
export var min_wait: int = 1

func enter():
	timer.wait_time = randi() % max_wait + min_wait
	timer.start()
