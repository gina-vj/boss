extends "res://entities/enemies/basic_enemy/states/AbstractBasicEnemyState.gd"

onready var timer: Timer = $Timer
export var max_wait: int = 1.5
export var min_wait: int = 1

func enter():
	parent.path = []
	parent.healed = true
	parent.healed_particles.emitting = true
	timer.wait_time = randi() % max_wait + min_wait
	timer.start()

func update(_delta):
	parent.navigate()


func exit():
	parent.healed = false
	parent.healed_particles.emitting = false
	timer.stop()

func _on_Timer_timeout():
	parent.healed = false
	parent.healed_particles.emitting = false
	emit_signal("finished", "wander")
