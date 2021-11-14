extends Node2D

var items=[]
var barbijos=[]
var attack_elements=[]
var point_attack_elements=0
var selected_attack_element=null
var duration_barbijo=0
var cant_alcohol=0
var max_duration_barbijo=0




func add_item(item):
	if item.is_in_group("barbijo"):
		barbijos.append(item)
	if item.is_in_group("alcohol"):
		attack_elements.append(item)
	if item.is_in_group("item"):
		items.append(item)
func count(color):
	var cant=0
	for item in items:
		if item.is_type() == color:
			cant=+1
	return cant
func use_barbijo():
	duration_barbijo=barbijos.pop_back().get_duration()
	max_duration_barbijo=duration_barbijo

func has_barbijo():
	return barbijos.size()>0	

func set_attack_elements(name_element):
	if selected_attack_element!=null:
		attack_elements.append(selected_attack_element)		
	var attack_elements_select_new
	for item in attack_elements:
		if (item.is_in_group("alcohol")) :
			selected_attack_element=item
			point_attack_elements=item.get_point()
			attack_elements.remove(attack_elements.find(item,0))

func equipated():
	return attack_elements!=null
func attack_element_use():
	selected_attack_element.point-=1

func get_point_attack_element():
	return selected_attack_element!=null and selected_attack_element.point
func get_duration_barbijo():
	return duration_barbijo
func cant_alcohol():
	return cant_alcohol
func has_costume():
	return false
func cant_barbijos():
	return barbijos.size()
