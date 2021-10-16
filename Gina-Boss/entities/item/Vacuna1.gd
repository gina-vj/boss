extends KinematicBody2D
class_name Vacuna

onready var detection_area = $DetectionArea

func _ready():
	pass

func initialize(container, my_position):
	container.add_child(self)
	global_position = my_position

func _on_DetectionArea_body_entered(body):
	body.item_detected(self)
	
	
func _on_DetectionArea_body_exited(body):
	body.item_not_detected()
