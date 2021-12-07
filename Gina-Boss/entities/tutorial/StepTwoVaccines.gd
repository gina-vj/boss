extends Node

onready var laser_door = $LaserDoor
func _ready():
	laser_door.open()
	laser_door.lock()

func _on_FinishTrigger_body_entered(body):
	laser_door.close()
	laser_door.lock()
