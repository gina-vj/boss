extends "res://entities/AbstractState.gd"

func enter():
	parent.expend_stamina_timer.stop()
	parent.recover_stamina_timer.start()

func update(_delta):
	if parent.velocity == Vector2.ZERO  :
		emit_signal("finished", "idle")
	if _can_run():
		emit_signal("finished", "dash")
	
	parent._handle_move_input()
	parent._handle_protection()
	parent._apply_movement()

func handle_input(event:InputEvent):
	parent._handle_attack(event)


func _can_run():
	return Input.is_action_pressed("dash") && PlayerData.current_stamina > 0
