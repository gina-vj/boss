extends Sprite

onready var shooter_tip = $ShooterTip

export (PackedScene) var item_throwable_scene:PackedScene

var item_throwable_container
var item_instance 

func shoot():
	item_instance = item_throwable_scene.instance()
	item_instance.initialize(item_throwable_container, shooter_tip.global_position, global_position.direction_to(shooter_tip.global_position))


func add_collision_exception_to_projectile(object):
	item_instance.add_collision_exception_to_projectile(object)
