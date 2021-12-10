extends Node

func _on_Area2D_body_entered(_body):
	PlayerData.entry_zone_security()


func _on_Area2D_body_exited(_body):
	PlayerData.out_zone_security()
