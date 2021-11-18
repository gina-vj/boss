extends Node
class_name Alcohol

const type: String= "ALCOHOL"

const velocity:int = 300
const duration:float = 1.0
const disinfection_duration = 6

var scene setget ,get_scene

func get_scene():
	return load("res://entities/item/alcohol/ThrowableAlcohol.tscn")

func hit(enemy):
	enemy.desinfect_area(disinfection_duration)
