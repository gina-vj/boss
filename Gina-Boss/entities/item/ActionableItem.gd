extends Node2D
class_name ActionableItem

onready var detection_area = $DetectionArea

func initialize(container, my_position):
	container.add_child(self)
	global_position = my_position

func _remove():
	#Bag.add_item(self)
	detection_area.remove_and_skip()
	hide() 
	
func _on_DetectionArea_body_entered(_body):
	_remove()
	
	

