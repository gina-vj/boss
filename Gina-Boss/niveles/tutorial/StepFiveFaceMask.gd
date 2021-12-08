extends Node

onready var laser_door = $LaserDoor
onready var icon_info=$CanvasLayer/Container/IconInfo
onready var timer=$Timer
func _ready():
	laser_door.close()
	laser_door.lock()
	pass # Replace with function body.

func _on_FinishTrigger_body_entered(body):
	laser_door.open()
	icon_info.visible=true
	timer.start(1)


func _on_Timer_timeout():
	icon_info.visible=false
