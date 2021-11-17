extends Node2D

func _on_Area_body_entered(_body):
	PlayerData.game_over()
