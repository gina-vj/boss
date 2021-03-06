extends KinematicBody2D
class_name Player

onready var state_machine = $StateMachine
onready var shooter = $Shooter
onready var body:Sprite = $Body
onready var collision_shape = $CollisionShape2D
onready var animation_base_player:AnimationPlayer=$AnimationBase
onready var animation_face_mask_player:AnimationPlayer=$AnimationFaceMask
onready var player_sfx:AudioStreamPlayer=$PlayerSfx
onready var expend_stamina_timer: Timer = $ExpendStaminaTimer
onready var recover_stamina_timer: Timer = $RecoverStaminaTimer
onready var particle_stamina=$Particles2D
onready var up_ray_casts: Node = $UpRayCasts
onready var down_ray_casts: Node = $DownRayCasts
onready var left_ray_casts: Node = $LeftRayCasts
onready var right_ray_casts: Node = $RightRayCasts
onready var contagion_area = $Area

export (int) var max_health = 20
export (int) var max_stamina = 5
export (float) var ACCELERATION:float = 10.0
export (float) var SPEED_LIMIT:float = 170.0
export (float) var FRICTION_WEIGHT:float = 0.2
export (float) var SPEED_WHILE_DEAD:int = 150
export (AudioStream) var fire_sfx
export (AudioStream) var injured_sfx
export (AudioStream) var grab_item_sfx
export (AudioStream) var dead_sfx


const MINIMUM_DISTANCE_TO_PATROLL_POINT = 30
var using_barbijo=false
var can_shoot=false
var item_throwable_container
var velocity:Vector2 = Vector2.ZERO
var direction:Vector2 = Vector2.UP
var patroll_to = null
var patroll_from = null
var path: Array = []
var direction_helper = DirectionHelper.new()

var area_protection = null

func initialize(_item_throwable_container):
	self.item_throwable_container = _item_throwable_container

func _ready():
	contagion_area.visible = false
	particle_stamina.emitting = false
	state_machine.set_parent(self)
	reset_health_and_stamina()

func reset_health_and_stamina():
	PlayerData.current_stamina = max_stamina
	PlayerData.current_health = max_health
	
func _handle_move_input():
	direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()
	velocity = direction * SPEED_LIMIT
		
func _handle_deacceleration():
	velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	velocity.y = lerp(velocity.y, 0, FRICTION_WEIGHT) if abs(velocity.y) > 1 else 0

func _handle_dead_movement():
	if direction == Vector2.ZERO:
		direction = next_direction(direction)
	
	direction_helper.deduce_direction(direction)
	if direction_helper.looking_up():
		check_ray_casts(up_ray_casts)
	elif direction_helper.looking_down():
		check_ray_casts(down_ray_casts)
	elif direction_helper.looking_left():
		check_ray_casts(left_ray_casts)
	elif direction_helper.looking_right():
		check_ray_casts(right_ray_casts)
	
	velocity = direction * SPEED_LIMIT

func check_ray_casts(ray_casts):
	for ray_cast in ray_casts.get_children():
		if ray_cast.is_colliding():
			direction = next_direction(direction)
			return

func next_direction(current_direction):
	if current_direction == Vector2(1, 0):
		return Vector2(1, 1)
	if current_direction == Vector2(1, 1):
		return Vector2(0, 1)
	if current_direction == Vector2(0, 1):
		return Vector2(-1, 0)
	if current_direction == Vector2(-1, 0):
		return Vector2(-1, -1)
	if current_direction == Vector2(-1, -1):
		return Vector2(0, -1)
	if current_direction == Vector2(0, -1):
		return Vector2(1, 0)
	if current_direction == Vector2(0, 0):
		return Vector2(1, 0)

func _apply_movement():
	get_material().set_shader_param("player_position", global_position)
	if PlayerData.still_alive():
		if velocity == Vector2.ZERO:
			play_idle_animation()
		else:
			play_moving_animation()
	else:
		dead_animation(velocity.normalized())
	
	velocity = move_and_slide(velocity)

func dead_animation(_direction):
	direction_helper.deduce_direction(_direction)
	if _direction == Vector2.ZERO:
		play_dead_idle_animation()
	else:
		play_dead_animation()

func notify_hit(amount):
	state_machine.notify_hit(amount)
	body.material.set_shader_param("flash_modifier",0.7)
	$TimerHurt.start()
	
func _remove():
	hide()
	collision_layer = 0
	
func receive_damage(amount):
	_injured_sfx()
	PlayerData.receive_area_damage(amount)

func play_idle_animation():
	var animation = ""
	direction_helper.deduce_direction(direction)
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
	
	animation_player().play(animation)

func play_moving_animation():
	var animation = ""
	direction_helper.deduce_direction(direction)
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
	
	animation_player().play(animation)


func play_dead_animation():
	var animation = ""
	if direction_helper.looking_up():
		animation = "infected_walk_up"
	elif direction_helper.looking_down():
		animation = "infected_walk_down"
	elif direction_helper.looking_left():
		body.flip_h  = true
		animation = "infected_walk_lateral"
	elif direction_helper.looking_right():
		body.flip_h = false
		animation = "infected_walk_lateral"
	
	animation_base_player.play(animation)

func play_dead_idle_animation():
	var animation = ""
	if direction_helper.looking_up():
		animation = "infected_idle_up"
	elif direction_helper.looking_down():
		animation = "infected_idle_down"
	elif direction_helper.looking_left():
		body.flip_h = true
		animation = "infected_idle_lateral"
	elif direction_helper.looking_right():
		body.flip_h = false
		animation = "infected_idle_lateral"
	
	animation_base_player.play(animation)

func animation_player():
	if !PlayerData.using_area_protection():
		animation_face_mask_player.stop()
		return animation_base_player
	else:
		animation_base_player.stop()
		return animation_face_mask_player
	
func _handle_attack(event: InputEvent):
	if Input.is_action_just_pressed("attack_left") and Bag.available_experimental_vaccines():
		shooter.rotation = ((get_global_mouse_position() - shooter.global_position).normalized()).angle()
		shooter.shoot(Bag.take_experimental_vaccine(), item_throwable_container)
		_fire_sfx()

	if event.is_action_pressed("attack_right") and Bag.available_alcohol():
		shooter.rotation = ((get_global_mouse_position() - shooter.global_position).normalized()).angle()
		shooter.shoot(Bag.take_alcohol(), item_throwable_container)
		_fire_sfx()

func _handle_protection():
	if !PlayerData.using_area_protection() && Bag.available_face_masks():
		PlayerData.use_area_protection(Bag.take_face_mask())

func still_alive():
	return PlayerData.still_alive()

func die():
	contagion_area.visible = true
	collision_shape.disabled = true
	set_collision_layer_bit(4, false)
	set_collision_layer_bit(1, false)
	collision_shape.disabled = false

func _fire_sfx():
	player_sfx.stream = fire_sfx
	player_sfx.play()
	
func notify_item_added():
	_grab_item_sfx()
	
func _injured_sfx():
	player_sfx.stream = injured_sfx
	player_sfx.play()

func _grab_item_sfx():
	player_sfx.stop()
	player_sfx.stream = grab_item_sfx
	player_sfx.play()
	

func _dead_sfx():
	player_sfx.stream = dead_sfx
	player_sfx.play()

func _on_TimerHurt_timeout():
	body.material.set_shader_param("flash_modifier", 0)
	


func _on_ExpendStaminaTimer_timeout():
	if PlayerData.current_stamina <= 0:
		state_machine.stamina_empty()
		expend_stamina_timer.stop()
	else:
		PlayerData.expend_stamina()

func _on_RecoverStaminaTimer_timeout():
	if PlayerData.current_stamina >= max_stamina:
		recover_stamina_timer.stop()
	else:
		PlayerData.recover_stamine()
