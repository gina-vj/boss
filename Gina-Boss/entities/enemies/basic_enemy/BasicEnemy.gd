extends KinematicBody2D
class_name BasicEnemy

export(int) var SPEED: int = 150
export(int) var contagion_zone_damage: int = 2
export(Vector2) var patroll_to = null
export(Vector2) var patroll_from = null
export (AudioStream) var injured_sfx

onready var raycast = $RayCast2D
onready var detection_area = $DetectionArea
onready var contagion_area = $ContationArea
onready var contagion_area_detector = $ContationArea/Detector
onready var disinfection_timer = $DisinfectionTimer
onready var state_machine = $StateMachine
onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var body:Sprite = $Body
onready var enemy_sfx:AudioStreamPlayer=$EnemySfx
onready var steps_sfx:AudioStreamPlayer2D=$EnemySteps
onready var healed_particles:Particles2D = $HealedParticles

const MINIMUM_DISTANCE_TO_TARGET = 30

var navigation: Navigation2D = null
var path: Array = []
var target_position: Vector2 = Vector2.ZERO
var target:Player = null
var contagion_target:Player = null
var velocity: Vector2 = Vector2.ZERO
var current_projectile = null
var direction_helper = DirectionHelper.new()
var healed = false

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
	direction_helper.deduce_direction(direction)
	if direction == Vector2.ZERO:
		play_idle_animation()
	else:
		play_moving_animation()

func can_see_target():
	if target == null:
		return false
	
	raycast.set_cast_to(to_local(target.global_position))
	raycast.force_raycast_update()
	return raycast.is_colliding() && raycast.get_collider() == target

func notify_hit(projectile):
	current_projectile = projectile
	projectile.hit(self)
	_injured_sfx()

func temporary_heal():
	state_machine.healed()	

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

func play_idle_animation():
	var animation = ""
	if direction_helper.looking_up():
		animation = "idle_up"
	elif direction_helper.looking_down():
		animation = "idle_down"
	elif direction_helper.looking_left():
		body.flip_h = true
		animation = "idle_lateral"
	elif direction_helper.looking_right():
		body.flip_h = false
		animation = "idle_lateral"

	if healed:
		animation = animation + "_healted"
	animation_player.play(animation)

func play_moving_animation():
	var animation = ""
	if direction_helper.looking_up():
		animation = "walk_up"
	elif direction_helper.looking_down():
		animation = "walk_down"
	elif direction_helper.looking_left():
		body.flip_h = true
		animation = "walk_lateral"
	elif direction_helper.looking_right():
		body.flip_h = false
		animation = "walk_lateral"
	
	animation_player.play(animation)

		
func _on_DisinfectionTimer_timeout():
	contagion_area.visible = true
	contagion_area_detector.set_deferred("disabled", false)

func _injured_sfx():
	enemy_sfx.stream = injured_sfx
	enemy_sfx.play()
