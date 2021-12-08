extends Node

export (PackedScene) var tutorial
export (PackedScene) var nivel1

onready var player = $Gina
onready var background = $Background/ColorRect
onready var screen_dimensions = get_viewport().size 
var nivel_actual = 1

func _ready():
	randomize()
	load_level()
	player.initialize(self)
	VisualServer.set_default_clear_color(Color.gray)

func load_level():
	var nuevo_nivel
	if(GameHandler.nivel_actual == 1):
		nuevo_nivel = tutorial.instance()
	elif(GameHandler.nivel_actual == 2):
		nuevo_nivel = nivel1.instance()
		
	add_child(nuevo_nivel)

func next_level():
	GameHandler.nivel_actual += 1
	get_tree().get_nodes_in_group("nivel")[0].queue_free()
	load_level()
	get_tree().get_nodes_in_group("Player")[0].position = Vector2(0,0)
	
