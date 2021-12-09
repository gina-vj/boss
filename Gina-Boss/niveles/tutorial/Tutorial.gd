extends Node

onready var gina = $Gina

func _ready():
	gina.initialize(self)

func _on_NextLevelTrigger_body_entered(_body):
	get_tree().get_nodes_in_group("main")[0].next_level()
