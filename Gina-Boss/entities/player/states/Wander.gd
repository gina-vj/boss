extends "res://entities/AbstractState.gd"

var level_navigation: Navigation2D

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	level_navigation = tree.get_nodes_in_group("LevelNavigation")[0]
	
func enter():
	parent.play_dead_animation()
	if level_navigation != null:
		parent.generate_path(level_navigation)

func update(_delta):
	if (parent.path.size() > 0):
		parent.navigate()
		parent._apply_movement()
	else:
		emit_signal("finished", "idleDead")
	
func exit():
	parent.path = []
