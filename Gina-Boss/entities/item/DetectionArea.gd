extends Area2D

func _input(event):
	if event.is_action_pressed("show_detection_area_turret"):
		green_circle.visible = !green_circle.visible
		
