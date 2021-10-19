extends Node2D


var items=[]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func add_item(item):
	items.append(item)
	print(items.size())

func count(color):
	var cant=0
	for item in items:
		if item.is_type() == color:
			cant=+1
	return cant
	
