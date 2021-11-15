extends "res://entities/enemies/basic_enemy/states/AbstractBasicEnemyState.gd"

onready var timer: Timer = $RecoveryTimer


func exit():
	timer.stop()


func _on_Timer_timeout():
	parent.infected()
	emit_signal("finished", "chase")


func enter():
	timer.start(5)
	parent.healed()
	
	if level_navigation != null:
		parent.path = generate_path()


func update(_delta):
	if (parent.path.size() > 0):
		parent.navigate()
	else:
		parent.path = generate_path()
		parent.navigate()

func notify_body_entered(_body):
	pass

func notify_body_exited(_body):
	pass

func notify_impact(_projectile):
	pass
		
