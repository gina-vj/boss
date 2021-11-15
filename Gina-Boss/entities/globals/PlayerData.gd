extends Node

signal max_health_updated(amount, current_health)
signal health_updated(amount, max_health)

var max_health:int
var current_health:int setget set_current_health
var area_protection = null

func set_max_health(amount:int)->void:
	max_health = amount
	current_health = max_health
	emit_signal("max_health_updated", max_health, current_health)

func set_current_health(amount:int)->void:
	current_health = amount
	emit_signal("health_updated", current_health, max_health)

func receive_area_damage(amount):
	if area_protection != null:
		area_protection.receive_damage(amount)
		
		if(!area_protection.still_useful()):
			area_protection = null
	else:
		current_health -= amount

func using_area_protection():
	return area_protection != null

func use_area_protection(protection):
	area_protection = protection

func still_alive():
	return current_health > 0
