extends "res://entities/AbstractState.gd"


func handle_input(event:InputEvent):
	if _is_moved(event) :
		emit_signal("finished", "walk")
	
func update(delta:float):
	parent._handle_deacceleration()
	parent._apply_movement()

func _is_moved(event):
	var is_moved = event.is_action_pressed("move_left") || event.is_action_pressed("move_right") || event.is_action_pressed("move_up") || event.is_action_pressed("move_down")
	return is_moved
