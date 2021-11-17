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
var path: Array = []
var target_position: Vector2 = Vector2.ZERO
var target:Player = null
var contagion_target:Player = null
var velocity: Vector2 = Vector2.ZERO
var current_projectile = null

enum Directions { UP, DOWN, LEFT, RIGHT }
var animation_direction = Directions.DOWN

func _ready():
	state_machine.set_parent(self)

func navigate():
	if path.size() > 0:
		target_position = path.front()
		if global_position.distance_to(target_position) < MINIMUM_DISTANCE_TO_TARGET:
			path.pop_front()
			velocity = Vector2.ZERO
		else:
			velocity = global_position.direction_to(target_position) * SPEED
	else:
		velocity = Vector2.ZERO
	
	show_animation(velocity.normalized())
	velocity = move_and_slide(velocity)

func show_animation(direction):
	var deduced_direction = deduce_direction(direction)
	if direction == Vector2.ZERO:
		play_idle_animation(animation_direction)
	else:
		play_moving_animation(deduced_direction)
		animation_direction = deduced_direction
		
func deduce_direction(direction):
	var coso = direction.angle()
	var angle = rad2deg(direction.angle())
	if angle < 0:
		angle = 360 + angle

	if angle <= 45 or angle > 315:
		return Directions.RIGHT
	elif angle > 45 and angle <= 135:
		return Directions.DOWN
	elif angle > 135 and angle <= 225:
		return Directions.LEFT
	elif angle > 225 and angle <= 315:
		return Directions.UP	

func can_see_target():
	if target == null:
		return false
	
	raycast.set_cast_to(to_local(target.global_position))
	raycast.force_raycast_update()
	return raycast.is_colliding() && raycast.get_collider() == target

func notify_hit(projectile):
	current_projectile = projectile
	projectile.hit(self)

func run_away():
	state_machine.run_away()	

func desinfect_area(time):
	contagion_area.visible = false
	contagion_area_detector.set_deferred("disabled", true)
	disinfection_timer.wait_time = time
	disinfection_timer.start()

func _on_DetectionArea_body_entered(_body):
	state_machine.notify_body_entered(_body)

func _on_DetectionArea_body_exited(_body):
	state_machine.notify_body_exited(_body)

func _on_ContationArea_body_entered(_body):
	state_machine.body_entered_contagion_area(_body)

func _on_ContationArea_body_exited(_body):
	state_machine.body_exited_contagion_area(_body)

func play_idle_animation(direction):
	var animation = ""
	match direction:
		Directions.UP:
			animation = "idle_up"
		Directions.DOWN:
			animation = "idle_down"
		Directions.LEFT:
			body.flip_h = true
			animation = "idle_lateral"
		Directions.RIGHT:
			body.flip_h = false
			animation = "idle_lateral"

	animation_player.play(animation)

func play_moving_animation(direction):
	var animation = ""
	match direction:
		Directions.UP:
			animation = "walk_up"
		Directions.DOWN:
			animation = "walk_down"
		Directions.LEFT:
			body.flip_h = true
			animation = "walk_lateral"
		Directions.RIGHT:
			body.flip_h = false
			animation = "walk_lateral"

	animation_player.play(animation)
		
func _on_DisinfectionTimer_timeout():
	contagion_area.visible = true
	contagion_area_detector.set_deferred("disabled", false)


