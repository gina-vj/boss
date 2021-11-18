extends "res://entities/AbstractState.gd"


func update(_delta):
	parent._handle_move_input()
	parent._handle_protection()
	parent._apply_movement()
	parent.play_moving_animation()
	if parent.velocity == Vector2.ZERO  :
		emit_signal("finished", "idle")

func handle_input(event:InputEvent):
	if _is_dash(event):
		emit_signal("finished", "dash")
	else:
		parent._handle_attack(event)


func _is_dash(event):
	return event.is_action_pressed("dash")
