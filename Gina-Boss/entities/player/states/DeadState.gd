extends "res://entities/AbstractState.gd"

func enter():
	parent.die()
	emit_signal("finished", "wander")

func update(_delta):
	parent._handle_deacceleration()
	parent._apply_movement()
