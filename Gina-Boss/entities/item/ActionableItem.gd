extends Node2D
class_name ActionableItem

onready var detection_area = $DetectionArea

func initialize(container, my_position):
	container.add_child(self)
	global_position = my_position

func _remove():
	Bag.add_item(self)
	hide() 
	

func _on_DetectionArea_body_entered(body):
	if body is Player:
		self._remove()
	
