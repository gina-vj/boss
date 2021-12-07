extends Node2D
onready var icon =$Icon
onready var timerOn=$TimerOn
onready var timerOff=$TimerOff
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	for i in range(10):
		icon.material.set_shader_param("progress",-1)
		timerOn.start()


func _on_Area2D_body_exited(body):
	pass # Replace with function body.


func _on_TimerOff_timeout():
	pass # Replace with function body.


func _on_TimerOn_timeout():
		icon.material.set_shader_param("progress",icon.material.get_shader_param("progress")+1)
