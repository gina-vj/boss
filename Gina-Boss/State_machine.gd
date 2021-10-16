extends "res://entities/AbstractStateMachine.gd"


func _ready():
	states_map = {
		"idle": $Idle,
		"walk": $Walk,
		
	}


func notify_hit(amount):
	pass


