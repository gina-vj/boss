extends Node2D

class_name Item

export var item_quantity = 0
export(int, "Alcohol", "Experimental Vaccine", "Face Mask", "Suit") var item_type_index = 0

onready var item_quantity_node = $ItemQuantityBackground/ItemQuantity

var type = null

func _ready():
	type = index_to_type()
	item_quantity_node.text = str(item_quantity)

func index_to_type():
	return [
		Alcohol.type,
		ExperimentalVaccine.type,
		FaceMask.type,
		Suit.type
	][item_type_index]


func _on_DetectionArea_body_entered(body):
	Bag.add_item(type, item_quantity)
	queue_free()