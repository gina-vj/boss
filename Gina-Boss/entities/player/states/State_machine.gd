extends "res://entities/AbstractStateMachine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"walk": $Walk,
		"dash": $Dash,
		"dead": $Dead,
		"idleDead": $IdleDead,
		"wander": $Wander
	}

func notify_hit(amount):
	var player = get_parent()
	player.receive_damage(amount)
	if(!player.still_alive()):
		_change_state("dead")

func stamina_empty():
	_change_state("walk")
