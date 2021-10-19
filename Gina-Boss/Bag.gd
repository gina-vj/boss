extends Node2D


var items=[]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func add_item(item):
	items.append(item)
	print(items.size())

func count(color):
	pass
	
