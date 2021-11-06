extends KinematicBody2D
class_name Player


onready var state_machine = $StateMachine
onready var shooter = $Shooter
onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var body:Sprite = $Body

const FLOOR_NORMAL := Vector2.UP
const SNAP_DIRECTION := Vector2.DOWN
const SNAP_LENGTH := 32.0
const SLOPE_THRESHOLD := deg2rad(60)

export (int) var max_health = 20
export (float) var ACCELERATION:float = 30.0
export (float) var H_SPEED_LIMIT:float = 400.0
export (int) var jump_speed = 1000
export (float) var FRICTION_WEIGHT:float = 0.2
export (int) var gravity = 30
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
	move_direction_x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	move_direction_y= int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if move_direction_x != 0:
		velocity.x = clamp(velocity.x + (move_direction_x * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	if move_direction_y != 0:
		velocity.y = clamp(velocity.y + (move_direction_y * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	if velocity != Vector2.ZERO:
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
	if Input.is_action_just_pressed("shoot") and (_can_shoot()==false and Bag.has_throwable()):
		
		can_shoot=true
		Bag.alcohol_used()
		$Shooter/Timer.start(Bag.get_duration_alcohol())
	
	if Input.is_action_just_pressed("shoot") and can_shoot :
		print("disparaa")
		if item_throwable_container == null:
			item_throwable_container = get_parent()
			shooter.item_throwable_container = item_throwable_container
		shooter.shoot(direction)




func _on_Timer_timeout():
	print("termine")
	can_shoot=false
	$Shooter/Timer.stop()

