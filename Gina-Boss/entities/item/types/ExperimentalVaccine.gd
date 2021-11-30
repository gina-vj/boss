extends Node
class_name ExperimentalVaccine

const type: String = "EXPERIMENTAL_VACCINE"
const velocity:int = 300
const duration:float = 0.5
const innoculation_duration = 3

var scene setget ,get_scene

func get_scene():
	return load("res://entities/item/experimental_vaccines/ThrowableExperimentalVaccine.tscn")

func hit(enemy):
	enemy.run_away()
