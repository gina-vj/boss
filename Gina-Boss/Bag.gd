extends Node2D

var items=[]
var cantBarbijos=0
var cantAlcohol=0
func add_item(item):
	items.append(item)

func count(color):
	var cant=0
	for item in items:
		if item.is_type() == color:
			cant=+1
	return cant

func has_throwable():
	var isThrowable = false
	for item in items:
		print(item.get_name())
		isThrowable = isThrowable or item.is_throwable()
	
	return isThrowable
