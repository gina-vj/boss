extends Node

signal first_component_found()
signal second_component_found()
signal third_component_found()
signal game_over()
signal player_dead()
signal restart()
signal main_menu()

var current_health:int
var area_protection = null

func first_component_found():
	emit_signal("first_component_found")

func second_component_found():
	emit_signal("second_component_found")

func third_component_found():
	emit_signal("third_component_found")

func receive_area_damage(amount):
	if area_protection != null:
		area_protection.receive_damage(amount)
		
		if(!area_protection.still_useful()):
			area_protection = null
	else:
		current_health -= amount
		if current_health <= 0:
			emit_signal("player_dead")

func using_area_protection():
	return area_protection != null

func use_area_protection(protection):
	area_protection = protection

func still_alive():
	return current_health > 0

func game_over():
	emit_signal("game_over")

func restart():
	emit_signal("restart")

func main_menu():
	emit_signal("main_menu")
