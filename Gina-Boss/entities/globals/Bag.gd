extends Node
class_name PlayerBag

var items=[]
var barbijos=[]
var attack_elements=[]
var point_attack_elements=0
var selected_attack_element=null
var duration_barbijo=0
var cant_alcohol=0
var max_duration_barbijo=0

var face_masks = 0
var suits = 0
var experimental_vaccines = 0
var alcohol = 0


func add_item(type, quantity):
	match type:
		FaceMask.type:
			face_masks += quantity
		Alcohol.type:
			alcohol += quantity
		ExperimentalVaccine.type:
			experimental_vaccines += quantity
		Suit.type:
			suits += quantity

func available_face_masks():
	return face_masks > 0

func take_face_mask():
	face_masks -= 1
	return FaceMask.new()

func set_attack_elements(name_element):
	if selected_attack_element!=null:
		attack_elements.append(selected_attack_element)		
	var attack_elements_select_new
	for item in attack_elements:
		if (item.is_in_group("alcohol")) :
			selected_attack_element=item
			point_attack_elements=item.get_point()
			attack_elements.remove(attack_elements.find(item,0))
