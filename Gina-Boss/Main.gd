extends Node

export (PackedScene) var tutorial
export (PackedScene) var nivel1

onready var background = $Background/ColorRect
onready var transitionAnimation = $GUI/TransitionAnimation
onready var screen_dimensions = get_viewport().size 
var nivel_actual = 1

func _ready():
	randomize()
	load_level()
	VisualServer.set_default_clear_color(Color.gray)

func load_level():
	var nuevo_nivel
	if(GameHandler.nivel_actual == 1):
		nuevo_nivel = tutorial.instance()
	elif(GameHandler.nivel_actual == 2):
		nuevo_nivel = nivel1.instance()
		
	add_child(nuevo_nivel)

func next_level():
	transitionAnimation.play("fade")
	GameHandler.nivel_actual += 1
	yield(transitionAnimation, "animation_finished")
	get_tree().get_nodes_in_group("nivel")[0].queue_free()
	load_level()
	transitionAnimation.play_backwards("fade")

