class_name FaceMask

const type: String = "FACE_MASK"
const protection_points:int = 10

var current_protecion_points:int = 0

func _init():
	current_protecion_points = protection_points

func still_useful():
	return current_protecion_points > 0

func receive_damage(amount):
	current_protecion_points -= amount
