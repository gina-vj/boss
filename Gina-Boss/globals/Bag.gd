extends Node
class_name PlayerBag

signal player_found_face_masks()
signal player_found_alcohol()
signal player_found_experimental_vaccines()

var face_masks = 0
var suits = 0
var experimental_vaccines = 0
var alcohol = 0

func _ready():
	PlayerData.connect("restart", self, "_on_restart")
	
func add_item(type, quantity):
	match type:
		FaceMask.type:
			emit_signal("player_found_face_masks")
			face_masks += quantity
		Alcohol.type:
			emit_signal("player_found_alcohol")
			alcohol += quantity
		ExperimentalVaccine.type:
			emit_signal("player_found_experimental_vaccines")
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
	
func _on_restart():
	face_masks = 0
	suits = 0
	experimental_vaccines = 0
	alcohol = 0

func has_throwable_items():
	return available_experimental_vaccines() or available_alcohol()
