extends "res://entities/AbstractState.gd"

func enter():
	if(Input.is_action_just_released("move_left")):
		parent.body.flip_h = true
		parent._play_animation("idle_lateral")
	if(Input.is_action_just_released("move_right")):
		parent.body.flip_h = false
		parent._play_animation("idle_lateral")
	if(Input.is_action_just_released("move_up")):
		parent._play_animation("idle_up")
	if(Input.is_action_just_released("move_down")):
		parent._play_animation("idle_down")


func handle_input(event:InputEvent):
	if _is_dash(event):
		emit_signal("finished", "dash")
	if _is_moving(event) :
		emit_signal("finished", "walk")
	
func update(delta:float):

	parent._handle_deacceleration()
	parent._apply_movement()
	parent._handle_shooter_actions()

func _is_dash(event):
	return event.is_action_pressed("dash")

func _is_moving(event: InputEvent):
	return (
		event.is_action_pressed("move_left") || 
		event.is_action_pressed("move_right") || 
		event.is_action_pressed("move_up") || 
		event.is_action_pressed("move_down")
	)
