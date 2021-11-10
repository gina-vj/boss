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


func update(delta):
	if (parent.path.size() > 0):
		parent.navigate()
	else:
		parent.path = generate_path()
		parent.navigate()

func notify_body_entered(body):
	pass

func notify_body_exited(body):
	pass

func notify_impact(projectile):
	pass
		
