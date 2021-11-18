extends "res://entities/AbstractState.gd"

func enter():
	parent.play_idle_animation()


func handle_input(event:InputEvent):
	parent._handle_attack(event)
	if _is_dash(event):
		emit_signal("finished", "dash")
	if _is_moving(event) :
		emit_signal("finished", "walk")
	
func update(_delta:float):
	parent._handle_protection()
	parent._handle_deacceleration()
	parent._apply_movement()

func _is_dash(event):
	return event.is_action_pressed("dash")

func _is_moving(event: InputEvent):
	return (
		event.is_action_pressed("move_left") || 
		event.is_action_pressed("move_right") || 
		event.is_action_pressed("move_up") || 
		event.is_action_pressed("move_down")
	)
