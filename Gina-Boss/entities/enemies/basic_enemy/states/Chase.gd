extends "res://entities/enemies/basic_enemy/states/AbstractBasicEnemyState.gd"

onready var timer = $ContagionTimer

func enter():
	parent.steps_sfx.play()

func update(_delta):
	if (parent.can_see_target() && level_navigation != null):
		var path: Array = level_navigation.get_simple_path(
			parent.global_position, 
			parent.target.global_position
		)
		path.pop_front()
		parent.path = path
		parent.navigate()
	else:
		emit_signal("finished", "idle")
		

func exit():
	timer.stop()
	parent.steps_sfx.stop()
	parent.path = []


func _on_ContagionTimmer_timeout():
	hurt_player_with_contagion_zone()


func _on_ContagionTimer_timeout():
	pass # Replace with function body.
