extends "res://entities/AbstractState.gd"

var still_recuperating = false

func _ready():
	still_recuperating = false


func enter():
	parent.expend_stamina_timer.start()
	parent.recover_stamina_timer.stop()
	parent.particle_stamina.visible=true
	if(parent.velocity.x>0):
		parent.particle_stamina.set_rotation_degrees(-90.0)
		parent.particle_stamina.position.x=-19
		parent.particle_stamina.position.y=34
	elif (parent.velocity.x<0):
		parent.particle_stamina.set_rotation_degrees(90.0)
		parent.particle_stamina.position.x=19
		parent.particle_stamina.position.y=34
	elif (parent.velocity.y>0):
		parent.particle_stamina.set_rotation_degrees(0.0)
		parent.particle_stamina.position.x=0
		parent.particle_stamina.position.y=-55
	elif (parent.velocity.y<0):
		parent.particle_stamina.set_rotation_degrees(-184.0)
		parent.particle_stamina.position.x=0
		parent.particle_stamina.position.y=55
func update(_delta):
	parent._handle_move_input()
	parent._handle_protection()
	parent.velocity = parent.velocity * 3
	parent._apply_movement()
	
	if not _is_moving() :
		emit_signal("finished", "idle")
	else:
		if not _is_running():
			emit_signal("finished", "walk")

func handle_input(event:InputEvent):
	parent._handle_protection()
	parent._handle_attack(event)

func _is_running():
	return Input.is_action_pressed("dash")

func _is_moving():
	return (
		Input.is_action_pressed("move_left") or
		Input.is_action_pressed("move_right") or
		Input.is_action_pressed("move_up") or
		Input.is_action_pressed("move_down")
	)


func exit():
	parent.expend_stamina_timer.stop()
	parent.recover_stamina_timer.start()
	parent.particle_stamina.visible=false
