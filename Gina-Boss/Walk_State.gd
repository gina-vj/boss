extends "res://entities/AbstractState.gd"

func update(delta):
	parent._handle_move_input()
	parent._apply_movement()
	if parent.move_direction_x == 0 && parent.move_direction_y == 0  :
		emit_signal("finished", "idle")
