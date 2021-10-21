extends "res://entities/enemies/basic_enemy/states/AbstractBasicEnemyState.gd"

onready var timer: Timer = $Timer

func enter():
	parent.path = []
	timer.start()


func _on_Timer_timeout():
	if parent.can_see_target():
		emit_signal("finished", "chase")
	else:
		emit_signal("finished", "wander")
