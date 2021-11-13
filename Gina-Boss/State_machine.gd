extends "res://entities/AbstractStateMachine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"walk": $Walk,
		"dash": $Dash,
		"dead": $Dead,
	}



func notify_hit(amount):
	if(!get_parent().using_barbijo):
		PlayerData.current_health -= min(amount, PlayerData.max_health)
		print(PlayerData.current_health)
		if PlayerData.current_health == 0:
			_change_state("dead")
