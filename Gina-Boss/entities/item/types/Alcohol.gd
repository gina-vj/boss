extends Node
class_name Alcohol

const type: String= "ALCOHOL"

const velocity:int = 300
const duration:float = 1.0
const disinfection_duration = 6

var texture_path setget ,get_texture

func get_texture():
	return load("res://assets/item/botella-de-alcohol.png")

func hit(enemy):
	enemy.desinfect_area(disinfection_duration)
