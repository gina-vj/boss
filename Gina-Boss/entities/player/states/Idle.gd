extends "res://entities/AbstractState.gd"

func enter():
	parent.expend_stamina_timer.stop()
	parent.recover_stamina_timer.start()
	
func handle_input(event:InputEvent):
	parent._handle_attack(event)
	
func update(_delta:float):
	if _is_moving() :
		if _can_run():
			emit_signal("finished", "dash")
		emit_signal("finished", "walk")

	parent._handle_move_input()
	parent._handle_protection()
	parent._handle_deacceleration()
	parent._apply_movement()

func _can_run():
	return Input.is_action_pressed("dash") and PlayerData.current_stamina > 0

func _is_moving():
	return (
		Input.is_action_pressed("move_left") || 
		Input.is_action_pressed("move_right") || 
		Input.is_action_pressed("move_up") || 
		Input.is_action_pressed("move_down")
	)
