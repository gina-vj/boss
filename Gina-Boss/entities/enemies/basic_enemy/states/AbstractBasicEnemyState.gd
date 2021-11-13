extends "res://entities/AbstractState.gd"

var level_navigation: Navigation2D

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	level_navigation = tree.get_nodes_in_group("LevelNavigation")[0]

func update(delta):
	if parent.can_see_target():
		emit_signal("finished", "chase")

func generate_path():
	var distance_to_start_patroll_point = parent.global_position.distance_to(parent.patroll_from)
	var distance_to_finish_patroll_point = parent.global_position.distance_to(parent.patroll_to)
	
	var path_to: Vector2 = Vector2.ZERO
	if distance_to_start_patroll_point >= distance_to_finish_patroll_point:
		if distance_to_finish_patroll_point <= parent.MINIMUM_DISTANCE_TO_TARGET:
			path_to = parent.patroll_from
		else:
			path_to = parent.patroll_to
	else:
		if distance_to_start_patroll_point <= parent.MINIMUM_DISTANCE_TO_TARGET:
			path_to = parent.patroll_to
		else:
			path_to = parent.patroll_from

	return level_navigation.get_simple_path(
		parent.global_position, 
		path_to,
		false
	)

func hurt_player_with_contagion_zone():
	if parent.contagion_target != null:
		parent.contagion_target.notify_hit(parent.contagion_zone_damage)

func body_entered_contagion_area(body):
	parent.contagion_target = body
	
	
func body_exited_contagion_area(body):
	parent.contagion_target = null
	body.protection.is_exited_contagion_area()

func notify_body_entered(body):
	parent.target = body


func notify_body_exited(body):
	if parent.can_see_target():
		emit_signal("finished", "idle")
	parent.target = null

func notify_impact(projectile):
	if projectile.is_in_group("alcohol"):
				emit_signal("finished", "impacted")
	if parent.is_still_ill():
		emit_signal("finished", "impacted")
	else:
		emit_signal("finished", "healed")
		
func notify_cura(body):
	pass


func item_detected(item):
	pass
