extends Node

func _ready():
	PlayerData.connect("restart", self, "_on_restart")

func _on_restart():
	get_tree().paused = false
	get_tree().change_scene("res://Main.tscn")
