extends Node2D
export var opened: bool = true
export var scala:Vector2=Vector2(0.5,0.5)
export (Texture) var textura
onready var icon =$Icon
onready var timerOn=$TimerOn
onready var timerOff=$TimerOff





func _ready():
	icon.texture=textura
	icon.scale=scala



func _on_Area2D_body_entered(body):
	for i in range(10):
		timerOn.start(0.1)




func _on_TimerOn_timeout():
	icon.material.set_shader_param("progress",icon.material.get_shader_param("progress")-0.1)
