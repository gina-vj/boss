extends KinematicBody2D
class_name ActionableItem

onready var detection_area = $DetectionArea

func initialize(container, my_position):
	container.add_child(self)
	global_position = my_position

func _remove():
	Bag.add_item(self)
	hide() 
	#esto hay que sacarlo pero para ello tenemos que guardar 
	#de manera mas inteligente en la mochila
	collision_layer = 0
	collision_mask = 0

func _on_DetectionArea_body_entered(body):

	if body.has_method("item_detected"):
		body.item_detected(self)
	
func _on_DetectionArea_body_exited(body):

	if body.has_method("item_not_detected"):
		body.item_not_detected()
