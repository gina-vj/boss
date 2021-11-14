extends KinematicBody2D
class_name Player


onready var state_machine = $StateMachine
onready var shooter = $Shooter
onready var animation_player:AnimationPlayer=$AnimationPlayer
onready var body:Sprite = $Body
onready var protection:Node2D=$Protection

const FLOOR_NORMAL := Vector2.UP
const SNAP_DIRECTION := Vector2.DOWN
const SNAP_LENGTH := 32.0
const SLOPE_THRESHOLD := deg2rad(60)

export (int) var max_health = 20
export (float) var ACCELERATION:float = 10.0
export (float) var SPEED_LIMIT:float = 170.0
export (float) var FRICTION_WEIGHT:float = 0.2
var using_barbijo=false
var can_shoot=false
var item_throwable_container
var velocity:Vector2 = Vector2.ZERO
var direction:Vector2 = Vector2.UP
var snap_vector:Vector2 = SNAP_DIRECTION * SNAP_LENGTH
var move_direction_x:int = 0
var move_direction_y:int = 0
var stop_on_slope:bool = true

func initialize(item_throwable_container):
	self.item_throwable_container = item_throwable_container
	shooter.item_throwable_container = item_throwable_container
	
func _ready():
	state_machine.set_parent(self)
	PlayerData.call_deferred("set_max_health", max_health)

func _handle_move_input():
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * SPEED_LIMIT

	direction = velocity.normalized()

func _handle_deacceleration():
	velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	velocity.y = lerp(velocity.y, 0, FRICTION_WEIGHT) if abs(velocity.y) > 1 else 0

func _apply_movement():
	velocity = move_and_slide(velocity)

func notify_hit(amount):
	state_machine.notify_hit(amount)
	
func _remove():
	hide()
	collision_layer = 0
	

func _play_animation(anim_name:String):
	if animation_player.has_animation(anim_name):
		animation_player.play(anim_name)

func _can_shoot():
	return can_shoot

func _handle_shooter_actions():
	Bag.set_attack_elements("Alcohol")
	if Input.is_action_just_pressed("shoot")  :
		Bag.set_attack_elements("Alcohol")
		Bag.attack_element_use()
		print("disparaa")
		if item_throwable_container == null:
			item_throwable_container = get_parent()
			shooter.item_throwable_container = item_throwable_container
		shooter.shoot(direction)


func can_use_barbijo():
	if Bag.has_barbijo() and !Bag.has_costume() and !using_barbijo:
		using_barbijo=true
		_set_animation($AnimationBarbijo,animation_player)
		Bag.use_barbijo()
		protection.set_duration(Bag.duration_barbijo)

func _set_animation(animationNew,animation_old):
	var name_animation_current=animation_old.current_animation
	animation_player.stop()
	animation_player=animationNew
	animation_player.play(name_animation_current)
	

func _on_Timer_timeout():
	can_shoot=false
	$Shooter/Timer.stop()



func _on_TimerProtection_timeout():
	animation_player.stop()
	_set_animation($AnimationPlayer,animation_player)
	using_barbijo=false
	$Protection/TimerProtection.stop()
