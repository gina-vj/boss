extends "res://entities/AbstractStateMachine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"wander": $Wander,
		"chase": $Chase,
		"attack": $Attack,
		"impacted": $Impacted,
		"healed": $Healed
	}

func notify_body_entered(body):
	current_state.notify_body_entered(body)


func notify_body_exited(body):
	current_state.notify_body_exited(body)


func notify_impact(projectile):
	current_state.notify_impact(projectile)
		
