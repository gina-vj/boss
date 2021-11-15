extends Node
class_name ExperimentalVaccine

const type: String = "EXPERIMENTAL_VACCINE"
const velocity:int = 500
const duration:int = 1
const innoculation_duration = 10

var texture_path setget ,get_texture

func get_texture():
	return load("res://assets/item/vacuna-roja.png")

func hit(enemy):
	enemy.run_away(innoculation_duration)
