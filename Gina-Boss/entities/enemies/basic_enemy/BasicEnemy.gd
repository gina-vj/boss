extends KinematicBody2D
class_name BasicEnemy

export(int) var SPEED: int = 40

onready var raycast = $RayCast2D
onready var detection_area = $DetectionArea
onready var state_machine = $StateMachine

var path: Array = []
var levelNavigation: Navigation2D = null
var target:Player = null
var velocity: Vector2 = Vector2.ZERO
var culo = Vector2.ZERO

func _ready():
	state_machine.set_parent(self)
	
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	var my_tilemap = levelNavigation.tile_map
	var map_position = my_tilemap.get_used_cells()[100]
	var local_position = my_tilemap.map_to_world(map_position)
	culo = my_tilemap.to_global(local_position)


func _physics_process(delta):
	if target != null and levelNavigation != null:
		generate_path()
		navigate()
		velocity = move_and_slide(velocity)

func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * SPEED
		if global_position == path[0]:
			path.pop_front()

func generate_path():
	path = levelNavigation.get_simple_path(
		global_position, 
		target.global_position, 
		false
	)
