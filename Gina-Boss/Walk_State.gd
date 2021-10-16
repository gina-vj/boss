extends "res://entities/AbstractState.gd"

func handle_input(event:InputEvent):
	
	if event.is_action_pressed("jump") && parent.is_on_floor():
			emit_signal("finished", "jump")


func update(delta):
	parent._handle_move_input()
	parent._apply_movement()
	if parent.move_direction_x == 0 && parent.move_direction_y == 0  :
		emit_signal("finished", "idle")
