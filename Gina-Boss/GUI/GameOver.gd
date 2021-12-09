extends Node

onready var background:ColorRect = $Background
onready var tween:Tween = $Tween
onready var finished:Control = $Finished
onready var dead:Control = $Dead
onready var ending_sfx:AudioStreamPlayer=$Ending

func _ready():
	# warning-ignore:return_value_discarded
	PlayerData.connect("game_over", self, "game_over")
	# warning-ignore:return_value_discarded
	PlayerData.connect("player_dead", self, "player_dead")
	
	background.color.a = 0
	background.visible = false
	finished.visible = false
	dead.visible = false

func game_over():
	finished.visible = true
	show_game_over_screen()
	ending_sfx.play()


func player_dead():
	dead.visible = true
	show_game_over_screen()

func show_game_over_screen():
	background.show()
	var transparent_black_overlay = Color( 0, 0, 0, 0.6 )
	# warning-ignore:return_value_discarded
	tween.interpolate_property(background, "color", background.color,  transparent_black_overlay / 1.3, 1)
	# warning-ignore:return_value_discarded
	tween.start()

func go_to_main_menu():
	PlayerData.main_menu()
	
func _on_restart_game_pressed():
	Bag.empty_bag()
	PlayerData.restart(false)
