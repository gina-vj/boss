extends Node
class_name PlayerBag

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

func available_experimental_vaccines():
	return experimental_vaccines > 0

func take_experimental_vaccine():
	experimental_vaccines -= 1
	return ExperimentalVaccine.new()
	
func available_alcohol():
	return alcohol > 0

func take_alcohol():
	alcohol -= 1
	return Alcohol.new()
