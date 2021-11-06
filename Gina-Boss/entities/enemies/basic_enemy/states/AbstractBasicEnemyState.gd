extends "res://entities/AbstractState.gd"

var level_navigation: Navigation2D

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	level_navigation = tree.get_nodes_in_group("LevelNavigation")[0]

func update(delta):
	if parent.can_see_target():
		emit_signal("finished", "chase")

func generate_random_path():
	var tilemap: TileMap = level_navigation.tile_map
	var cells: Array = tilemap.get_used_cells()

	var random_position = randi() % cells.size() + 0
	var local_position = tilemap.map_to_world(cells[random_position])

	return level_navigation.get_simple_path(
		parent.global_position, 
		tilemap.to_global(local_position) ,
		false
	)

func hurt_player_with_contagion_zone():
	if parent.contagion_target != null:
		parent.contagion_target.notify_hit(parent.contagion_zone_damage)

func body_entered_contagion_area(body):
	parent.contagion_target = body
	
func body_exited_contagion_area(body):
	parent.contagion_target = null

func notify_body_entered(body):
	parent.target = body


func notify_body_exited(body):
	parent.target = null
	if parent.can_see_target():
		emit_signal("finished", "idle")

func notify_impact(projectile):
	if parent.is_still_ill():
		emit_signal("finished", "impacted")
	else:
		emit_signal("finished", "healed")
		
func notify_cura(body):
	pass


func item_detected(item):
	pass