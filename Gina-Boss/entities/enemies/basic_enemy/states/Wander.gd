extends "res://entities/enemies/basic_enemy/states/AbstractBasicEnemyState.gd"

func enter():
	if level_navigation != null:
		parent.path = generate_random_path()

func update(delta):
	.update(delta)
	if (parent.path.size() > 0):
		parent.navigate()
	else:
		emit_signal("finished", "idle")

func exit():
	parent.path = []
