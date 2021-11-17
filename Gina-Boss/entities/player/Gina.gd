extends KinematicBody2D
class_name Player


onready var state_machine = $StateMachine
onready var shooter = $Shooter
onready var body:Sprite = $Body
onready var collision_shape = $CollisionShape2D
onready var animation_base_player:AnimationPlayer=$AnimationBase
onready var animation_face_mask_player:AnimationPlayer=$AnimationFaceMask

export (int) var max_health = 20
export (float) var ACCELERATION:float = 10.0
export (float) var SPEED_LIMIT:float = 170.0
export (float) var FRICTION_WEIGHT:float = 0.2

var using_barbijo=false
var can_shoot=false
var item_throwable_container
var velocity:Vector2 = Vector2.ZERO
var direction:Vector2 = Vector2.UP

var area_protection = null

func initialize(item_throwable_container):
	self.item_throwable_container = item_throwable_container
	
func _ready():
	state_machine.set_parent(self)
	PlayerData.current_health = max_health

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
	
func receive_damage(amount):
	PlayerData.receive_area_damage(amount)

func _play_animation(anim_name:String):
	animation_player().play(anim_name)

func animation_player():
	if PlayerData.using_area_protection():
		animation_base_player.stop()
		return animation_face_mask_player
	else:
		animation_face_mask_player.stop()
		return animation_base_player
	
func _handle_attack(event: InputEvent):
	if event.is_action_pressed("attack_left") and Bag.available_experimental_vaccines():
		shooter.rotation = ((get_global_mouse_position() - shooter.global_position).normalized()).angle()
		shooter.shoot(Bag.take_experimental_vaccine(), item_throwable_container)

	if event.is_action_pressed("attack_right") and Bag.available_alcohol():
		shooter.rotation = ((get_global_mouse_position() - shooter.global_position).normalized()).angle()
		shooter.shoot(Bag.take_alcohol(), item_throwable_container)
		
func _handle_protection():
	if !PlayerData.using_area_protection() && Bag.available_face_masks():
		PlayerData.use_area_protection(Bag.take_face_mask())

func still_alive():
	return PlayerData.still_alive()

func die():
	_play_animation("dead_down")
	collision_shape.disabled = true
	set_collision_layer_bit(4, false)
	collision_shape.disabled = false
	
