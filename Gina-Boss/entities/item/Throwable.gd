extends Node2D
class_name Throwable

var lifetime_timer: Timer
var hitbox: Area2D
var body: Sprite
var velocity:float = 0

var direction:Vector2
var throwable

func initialize(container, throwable, spawn_position:Vector2, direction:Vector2):
	container.add_child(self)
	
	body = $Body
	hitbox = $Hitbox
	lifetime_timer = $LifetimeTimer

	self.throwable = throwable

	self.direction = direction
	global_position = spawn_position
	velocity = throwable.velocity

	body.texture = throwable.texture_path
	body.rotation = direction.angle()
	
	lifetime_timer.wait_time = throwable.duration
	lifetime_timer.start()

func _physics_process(delta:float):
	position += direction * velocity * delta

func _remove():
	hitbox.collision_layer = 0
	hitbox.collision_mask = 0

	get_parent().remove_child(self)
	queue_free()

func _on_Hitbox_body_entered(body):
	if body.has_method("notify_hit"):
		body.notify_hit(throwable)
	
	lifetime_timer.stop()
	
	call_deferred("_remove")


func _on_LifetimeTimer_timeout():
	call_deferred("_remove")
