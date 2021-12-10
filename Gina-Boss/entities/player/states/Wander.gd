extends "res://entities/AbstractState.gd"

var level_navigation: Navigation2D

func update(_delta):
	parent._handle_dead_movement()
	parent._apply_movement()
	parent._handle_deacceleration()
