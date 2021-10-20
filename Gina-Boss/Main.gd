extends Node

onready var player = $Environment/Gina

func _ready():
	randomize()
	player.initialize(self)
