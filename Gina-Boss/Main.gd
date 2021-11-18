extends Node

onready var player = $Environment/Gina
onready var background = $Background/ColorRect
onready var screen_dimensions = get_viewport().size 

func _ready():
	randomize()
	player.initialize(self)
	VisualServer.set_default_clear_color(Color.gray)

func _process(_delta):
	#background.material.set_shader_param("player_position", player.global_position / screen_dimensions)
	pass
