extends Node

onready var background = $Background
onready var message = $Message
onready var tween = $Tween

func _ready():
	PlayerData.connect("game_over", self, "game_over")
	PlayerData.connect("player_dead", self, "player_dead")

	background.color.a = 0
	background.visible = false
	message.visible = false

func game_over():
	message.text = "Salvaste a la humanidad"
	show_game_over_screen()

func player_dead():
	message.text = "Perdiste, la humanidad esta condenada"

func show_game_over_screen():
	message.show()
	background.show()
	tween.interpolate_property(background, "color", background.color, Color.black, 1)
	tween.start()
