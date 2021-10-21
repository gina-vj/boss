extends "res://entities/enemies/basic_enemy/states/AbstractBasicEnemyState.gd"

func enter():
	parent.healed()
	if level_navigation != null:
		parent.path = generate_random_path()


func update(delta):
	if (parent.path.size() > 0):
		parent.navigate()
	else:
		parent.path = generate_random_path()
		parent.navigate()

func notify_body_entered(body):
	pass

func notify_body_exited(body):
	pass

func notify_impact(projectile):
	pass
		
