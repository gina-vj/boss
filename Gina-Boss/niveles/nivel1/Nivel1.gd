extends Node

onready var gina = $Gina

func _ready():
	gina.initialize(self)
	PlayerData.restart(true)
