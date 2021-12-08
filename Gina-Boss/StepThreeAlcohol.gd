extends Node

onready var laser_door = $LaserDoor
onready var navigation = $StepNavigation
func _ready():
	laser_door.open()
	laser_door.lock()
	
	for child in get_children():
		if child.is_in_group('enemy'):
			child.navigation = navigation

func _on_FinishTrigger_body_entered(body):
	laser_door.close()
