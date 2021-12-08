extends Node

onready var laser_door = $LaserDoor

func _ready():
	laser_door.close()
	laser_door.lock()
	pass # Replace with function body.

func _on_FinishTrigger_body_entered(body):
	laser_door.open()
