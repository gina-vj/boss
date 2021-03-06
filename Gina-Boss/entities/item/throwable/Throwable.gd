extends Node2D
class_name Throwable

var lifetime_timer: Timer
var hitbox: Area2D
var velocity:float = 0

var direction:Vector2
var throwable
var throwable_scene

func initialize(container, _throwable, spawn_position:Vector2, _direction:Vector2):
	container.add_child(self)
	
	hitbox = $Hitbox
	lifetime_timer = $LifetimeTimer

	self.throwable = _throwable

	self.direction = _direction
	global_position = spawn_position
	velocity = _throwable.velocity

	throwable_scene = _throwable.scene.instance()
	throwable_scene.rotation = _direction.angle()
	add_child(throwable_scene)
	
	lifetime_timer.wait_time = _throwable.duration
	lifetime_timer.start()

func _physics_process(delta:float):
	position += direction * velocity * delta

func _remove():
	hitbox.collision_layer = 0
	hitbox.collision_mask = 0

	if get_parent() != null:
		get_parent().remove_child(self)
	queue_free()

func _on_Hitbox_body_entered(body):
	if body.has_method("notify_hit"):
		body.notify_hit(throwable)
	
	lifetime_timer.stop()
	
	set_physics_process(false)
	throwable_scene.impact()
	yield(throwable_scene, "finished_impact")
	call_deferred("_remove")


func _on_LifetimeTimer_timeout():
	throwable_scene.impact()
	yield(throwable_scene, "finished_impact")
	call_deferred("_remove")
