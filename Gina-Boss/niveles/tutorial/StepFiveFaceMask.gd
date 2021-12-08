extends Node

onready var laser_door = $LaserDoor
onready var icon_info=$CanvasLayer/Container/IconInfo
onready var timer=$Timer
onready var navigation = $StepNavigation

func _ready():
	for child in get_children():
		if child.is_in_group('enemy'):
			child.navigation = navigation

func _on_FinishTrigger_body_entered(body):
	icon_info.visible=true
	timer.start(1)
	
	

func _on_Timer_timeout():
	icon_info.visible=false
