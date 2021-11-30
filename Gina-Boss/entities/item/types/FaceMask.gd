class_name FaceMask

const type: String = "FACE_MASK"
const protection_points:int = 10

var current_protection_points:int = 0

func _init():
	current_protection_points = protection_points

func still_useful():
	return current_protection_points > 0

func receive_damage(amount):
	current_protection_points -= amount
