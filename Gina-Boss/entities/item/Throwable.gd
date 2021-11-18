extends Node2D
class_name Throwable

var lifetime_timer: Timer
var hitbox: Area2D
var body: Sprite
var velocity:float = 0

var direction:Vector2
var throwable

onready var anim = $RotationAnimation

func initialize(container, _throwable, spawn_position:Vector2, _direction:Vector2):
	container.add_child(self)
	
	body = $Body
	hitbox = $Hitbox
	lifetime_timer = $LifetimeTimer

	self.throwable = _throwable

	self.direction = _direction
	global_position = spawn_position
	velocity = throwable.velocity

	body.texture = throwable.texture_path
	body.rotation = direction.angle()
	
	lifetime_timer.wait_time = throwable.duration
	lifetime_timer.start()
	_animate_projectile()

func _physics_process(delta:float):
	position += direction * velocity * delta

func _remove():
	hitbox.collision_layer = 0
	hitbox.collision_mask = 0

	get_parent().remove_child(self)
	queue_free()

func _animate_projectile():
	if direction.x >= 0:
		anim.play("rotate")
	else:
		anim.play_backwards("rotate")

func _on_Hitbox_body_entered(_body):
	if _body.has_method("notify_hit"):
		_body.notify_hit(throwable)
	
	lifetime_timer.stop()
	
	call_deferred("_remove")


func _on_LifetimeTimer_timeout():
	call_deferred("_remove")
