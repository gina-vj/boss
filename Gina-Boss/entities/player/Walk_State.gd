extends "res://entities/AbstractState.gd"

func enter():
	if(Input.is_action_just_pressed("move_left")):
		parent.body.flip_h = true
		parent._play_animation("walk_lateral")
	if(Input.is_action_just_pressed("move_right")):
		parent.body.flip_h = false
		parent._play_animation("walk_lateral")
	if(Input.is_action_just_pressed("move_up")):
		parent._play_animation("walk_up")
	if(Input.is_action_just_pressed("move_down")):
		parent._play_animation("walk_down")

func update(delta):
	parent.can_use_barbijo()
	parent._handle_move_input()
	parent._apply_movement()
	parent._handle_shooter_actions()
	if parent.velocity == Vector2.ZERO  :
		emit_signal("finished", "idle")

func handle_input(event:InputEvent):
	if _is_dash(event):
		emit_signal("finished", "dash")

func _is_dash(event):
	return event.is_action_pressed("dash")
