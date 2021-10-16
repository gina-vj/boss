extends KinematicBody2D
class_name Player

signal hit()
signal dead()


onready var state_machine = $StateMachine


const FLOOR_NORMAL := Vector2.UP
const SNAP_DIRECTION := Vector2.DOWN
const SNAP_LENGTH := 32.0
const SLOPE_THRESHOLD := deg2rad(60)

export (int) var max_health = 20
export (float) var ACCELERATION:float = 30.0
export (float) var H_SPEED_LIMIT:float = 400.0
export (int) var jump_speed = 1000
export (float) var FRICTION_WEIGHT:float = 0.1
export (int) var gravity = 30

var projectile_container

var velocity:Vector2 = Vector2.ZERO
var snap_vector:Vector2 = SNAP_DIRECTION * SNAP_LENGTH
var move_direction_x:int = 0
var move_direction_y:int = 0
var stop_on_slope:bool = true


func _ready():
	state_machine.set_parent(self)

func _handle_move_input():
	move_direction_x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	move_direction_y= int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if move_direction_x != 0:
		velocity.x = clamp(velocity.x + (move_direction_x * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	if move_direction_y != 0:
		velocity.y = clamp(velocity.y + (move_direction_y * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)

func _handle_deacceleration():
	velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	velocity.y = lerp(velocity.y, 0, FRICTION_WEIGHT) if abs(velocity.y) > 1 else 0




func _apply_movement():

	velocity = move_and_slide(velocity)



func notify_hit(amount):
	state_machine.notify_hit(amount)


func _remove():
	pass




