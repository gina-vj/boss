extends Node

onready var menu_button = get_parent().get_node("PausaCanvasLayer/MenuButton")

func _ready():
# warning-ignore:return_value_discarded
	PlayerData.connect("restart", self, "_on_restart")	
# warning-ignore:return_value_discarded
	PlayerData.connect("game_over", self, "_on_game_over")
# warning-ignore:return_value_discarded
	PlayerData.connect("main_menu", self, "_on_main_menu")

func _on_restart():
	pause(false)
	if get_tree().change_scene("res://Main.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Main scene")

func _on_PausaCanvasLayer_pausa():
	var actualState = menu_button.visible
	menu_button.visible = !actualState
	pause(!actualState)

func _on_game_over():
	pause(true)

func _on_main_menu():
	pause(false)
	
	if get_tree().change_scene("res://menu/Menu.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Menu scene")

func pause(status):
	get_tree().paused = status
