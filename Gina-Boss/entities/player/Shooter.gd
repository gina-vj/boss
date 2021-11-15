extends Node2D

onready var shooter_tip = $ShooterTip

export (PackedScene) var item_throwable_scene:PackedScene

var item_instance 

func shoot(throwable, container):
	var direction = global_position.direction_to(shooter_tip.global_position)
	item_instance = item_throwable_scene.instance()
	item_instance.initialize(container, throwable, shooter_tip.global_position, direction)
	

func add_collision_exception_to_projectile(object):
	item_instance.add_collision_exception_to_projectile(object)
