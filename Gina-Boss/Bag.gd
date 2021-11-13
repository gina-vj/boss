extends Node2D

var items=[]
var barbijos=[]
var alcohol=[]
var duration_alcohol=0

func add_item(item):
	if item.is_in_group("barbijo"):
		barbijos.append(item)
	if item.is_in_group("alcohol"):
		alcohol.append(item)
	if item.is_in_group("item"):
		items.append(item)
func count(color):
	var cant=0
	for item in items:
		if item.is_type() == color:
			cant=+1
	return cant

func has_throwable():
	return alcohol.size()>0
func has_barbijo():
	return barbijos.size()>0	

func alcohol_used():
	duration_alcohol=alcohol.pop_back().get_duration()
func get_duration_alcohol():
	return duration_alcohol
func cant_alcohol():
	return alcohol.size()
func has_costume():
	return false
func cant_barbijos():
	return barbijos.size()
