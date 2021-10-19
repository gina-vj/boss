extends KinematicBody2D
class_name BasicEnemy

export(int) var SPEED: int = 100
export(int) var illness: int = 20
export(int) var contagion_zone_damage: int = 1

onready var raycast = $RayCast2D
onready var detection_area = $DetectionArea
onready var state_machine = $StateMachine

const MINIMUM_DISTANCE_TO_TARGET = 30

var path: Array = []
var target_position: Vector2 = Vector2.ZERO
var target:Player = null
var velocity: Vector2 = Vector2.ZERO

func _ready():
	state_machine.set_parent(self)

func navigate():
	if path.size() > 0:
		var target_position = path.front()
		if global_position.distance_to(target_position) < MINIMUM_DISTANCE_TO_TARGET:
			path.pop_front()
			velocity = Vector2.ZERO
		else:
			velocity = global_position.direction_to(target_position) * SPEED
	else:
		velocity = Vector2.ZERO

	velocity = move_and_slide(velocity)

func can_see_target():
	if target == null:
		return false
	
	raycast.set_cast_to(to_local(target.global_position))
	raycast.force_raycast_update()
	return raycast.is_colliding() && raycast.get_collider() == target
	
func is_still_ill():
	return illness > 0

func notify_hit(projectile):
	illness -= projectile.heal_points
	state_machine.notify_hit(projectile)

func _on_DetectionArea_body_entered(body):
	state_machine.notify_body_entered(body)


func _on_DetectionArea_body_exited(body):
	state_machine.notify_body_exited(body)
