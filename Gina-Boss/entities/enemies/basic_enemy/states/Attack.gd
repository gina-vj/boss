extends "res://entities/enemies/basic_enemy/states/AbstractBasicEnemyState.gd"

func enter():
	parent.path = []

func update(delta):
	if parent.can_see_target() && parent.distance_to_target() <= parent.MINIMUM_DISTANCE_TO_TARGET:
		# aca podemos agregar logica de ataque onda estornudar o algo asi
		pass
	elif parent.can_see_target():
		emit_signal("finished", "chase")
	else:
		emit_signal("finished", "idle")


func _on_ContagionTimer_timeout():
	hurt_player_with_contagion_zone()
