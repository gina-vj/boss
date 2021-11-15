extends "res://entities/enemies/basic_enemy/states/AbstractBasicEnemyState.gd"

onready var timer:Timer = $Timer

func enter():
	timer.wait_time = parent.current_projectile.innoculation_duration
	timer.start()

func update(_delta):
	if (parent.can_see_target() && level_navigation != null):
		var path: Array = level_navigation.get_simple_path(
			parent.global_position, 
			parent.patroll_from
		)
		path.pop_front()
		parent.path = path
		parent.navigate()

func exit():
	timer.stop()
	parent.path = []

func _on_Timer_timeout():
	emit_signal("finished", "idle") # Replace with function body.

func notify_body_entered(_body):
	pass

func notify_body_exited(_body):
	pass
