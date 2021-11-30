extends Node

onready var menu_button = get_parent().get_node("PausaCanvasLayer/MenuButton")

func _ready():
	PlayerData.connect("restart", self, "_on_restart")	
	PlayerData.connect("game_over", self, "_on_game_over")
	PlayerData.connect("main_menu", self, "_on_main_menu")

func _on_restart():
	pause(false)
	get_tree().change_scene("res://Main.tscn")

func _on_PausaCanvasLayer_pausa():
	var actualState = menu_button.visible
	menu_button.visible = !actualState
	pause(!actualState)

func _on_game_over():
	pause(true)

func _on_main_menu():
	pause(false)
	get_tree().change_scene("res://menu/Menu.tscn")

func pause(status):
	get_tree().paused = status
