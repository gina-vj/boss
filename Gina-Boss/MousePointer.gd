extends Node2D

var arrow: Resource = load("res://assets/crosshair.png")

func _ready():
	Input.set_custom_mouse_cursor(arrow, 0, Vector2(20,20))

