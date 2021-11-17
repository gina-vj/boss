extends Node

onready var background:ColorRect = $Background
onready var tween:Tween = $Tween
onready var finished:Control = $Finished
onready var dead:Control = $Dead

func _ready():
	PlayerData.connect("game_over", self, "game_over")
	PlayerData.connect("player_dead", self, "player_dead")

	background.color.a = 0
	background.visible = false
	finished.visible = false
	dead.visible = false

func game_over():
	finished.visible = true
	get_tree().paused = true
	show_game_over_screen()

func player_dead():
	dead.visible = true
	show_game_over_screen()

func show_game_over_screen():
	background.show()
	tween.interpolate_property(background, "color", background.color, Color.black / 1.3, 1)
	tween.start()

func go_to_main_menu():
	get_tree().paused = false
	get_tree().change_scene("res://screens/Menu.tscn")
	
func restart_game():
	get_tree().paused = false
	get_tree().reload_current_scene()
