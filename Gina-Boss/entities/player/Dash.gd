extends "res://entities/player/Walk_State.gd"

onready var timer = $DashTimer
onready var recuperation_timer = $DashRecuperationTimer

var still_recuperating = false

func _ready():
	still_recuperating = false
	

func enter():
	if still_recuperating:
		emit_signal("finished", "walk")
	else:
		.enter()
		timer.start()


func update(delta):
	.update(delta)
	parent.velocity = parent.velocity * 2
	parent._apply_movement()


func exit():
	timer.stop()
	if !still_recuperating:
		still_recuperating = true
		recuperation_timer.start()


func _on_DashTimer_timeout():
	emit_signal("finished", "walk")


func _on_DashRecuperationTimer_timeout():
	still_recuperating = false
