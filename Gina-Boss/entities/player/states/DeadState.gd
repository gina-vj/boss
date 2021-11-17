extends "res://entities/AbstractState.gd"

func enter():
	parent.die()

func update(_delta):
	parent._handle_deacceleration()
	parent._apply_movement()
