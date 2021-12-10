extends Node

onready var menu_button = get_parent().get_node("PausaCanvasLayer/MenuButton")
onready var background_music = get_parent().get_node("GUI/BackgroundMusic")
onready var stream_background= background_music.stream
func _ready():
# warning-ignore:return_value_discarded
	PlayerData.connect("restart", self, "_on_restart")	
# warning-ignore:return_value_discarded
	PlayerData.connect("game_over", self, "_on_game_over")
# warning-ignore:return_value_discarded
	PlayerData.connect("main_menu", self, "_on_main_menu")
# warning-ignore:return_value_discarded
	PlayerData.connect("entry_zone_security",self,"_change_music_security")
# warning-ignore:return_value_discarded
	PlayerData.connect("out_zone_security",self,"_change_music_background")

func _change_music_security():
	background_music.stream=load("res://assets/audio/security.ogg")
	background_music.play()
func _change_music_background():
	background_music.stream=load("res://assets/audio/ambient.mp3")
	background_music.play()
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

