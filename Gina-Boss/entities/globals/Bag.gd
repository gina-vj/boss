extends Node
class_name PlayerBag

var items=[]
var barbijos=[]
var attack_elements=[]
var point_attack_elements=0
var selected_attack_element=""
var duration_barbijo=0
var cant_alcohol=0
var max_duration_barbijo=0

var face_masks = 0
var suits = 0
var experimental_vaccines = 0
var alcohol = 0
func get_quantity_selected_attack_item():
	var quantity=0
	match selected_attack_element:
		FaceMask.type:
			quantity=face_masks 
		Alcohol.type:
			quantity=alcohol
		ExperimentalVaccine.type:
			quantity= experimental_vaccines 
		Suit.type:
			quantity=suits 
	return quantity
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
func attack_element_use():
	match selected_attack_element:
		FaceMask.type:
			face_masks -= 1
		Alcohol.type:
			alcohol -= 1
		ExperimentalVaccine.type:
			experimental_vaccines -= 1
		Suit.type:
			suits -= 1
func available_face_masks():
	return face_masks > 0

func take_face_mask():
	face_masks -= 1
	return FaceMask.new()

func set_attack_elements(name_element):
	selected_attack_element=name_element
