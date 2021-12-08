extends Node


func _on_NextLevelTrigger_body_entered(body):
	get_tree().get_nodes_in_group("main")[0].next_level()
