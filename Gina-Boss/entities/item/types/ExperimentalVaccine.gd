extends Node
class_name ExperimentalVaccine

const type: String = "EXPERIMENTAL_VACCINE"
const velocity:int = 300
const duration:float = 0.8
const innoculation_duration = 5

var scene setget ,get_scene

func get_scene():
	return load("res://entities/item/experimental_vaccines/ThrowableExperimentalVaccine.tscn")

func hit(enemy):
	enemy.temporary_heal()
	enemy.desinfect_area(innoculation_duration)
