extends KinematicBody2D
class_name BasicEnemy

export(int) var SPEED: int = 150
export(int) var contagion_zone_damage: int = 1
export(Vector2) var patroll_to = null
export(Vector2) var patroll_from = null

onready var raycast = $RayCast2D
onready var detection_area = $DetectionArea
onready var contagion_area = $ContationArea
onready var contagion_area_detector = $ContationArea/Detector
onready var disinfection_timer = $DisinfectionTimer
onready var state_machine = $StateMachine
onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var body:Sprite = $Body

const MINIMUM_DISTANCE_TO_TARGET = 30
var away=1
var path: Array = []
var target_position: Vector2 = Vector2.ZERO
var target:Player = null
var contagion_target:Player = null
var velocity: Vector2 = Vector2.ZERO
var current_projectile = null

func _ready():
	state_machine.set_parent(self)

func navigate():
	if path.size() > 0:
		var target_position = path.front()
		if global_position.distance_to(target_position) < MINIMUM_DISTANCE_TO_TARGET:
			path.pop_front()
			velocity = Vector2.ZERO
		else:
			velocity = away*global_position.direction_to(target_position) * SPEED
	else:
		velocity = Vector2.ZERO

	velocity = move_and_slide(velocity)

func can_see_target():
	if target == null:
		return false
	
	raycast.set_cast_to(to_local(target.global_position))
	raycast.force_raycast_update()
	return raycast.is_colliding() && raycast.get_collider() == target

func notify_hit(projectile):
	current_projectile = projectile
	projectile.hit(self)

func run_away(time):
	state_machine.run_away()	

func desinfect_area(time):
	contagion_area.visible = false
	contagion_area_detector.set_deferred("disabled", true)
	disinfection_timer.wait_time = time
	disinfection_timer.start()

func _on_DetectionArea_body_entered(body):
	state_machine.notify_body_entered(body)

func _on_DetectionArea_body_exited(body):
	state_machine.notify_body_exited(body)

func _on_ContationArea_body_entered(body):
	state_machine.body_entered_contagion_area(body)

func _on_ContationArea_body_exited(body):
	state_machine.body_exited_contagion_area(body)

func _play_animation(anim_name:String):
	if animation_player.has_animation(anim_name):
		animation_player.play(anim_name)
		
func _on_DisinfectionTimer_timeout():
	contagion_area.visible = true
	contagion_area_detector.set_deferred("disabled", false)


