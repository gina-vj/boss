extends StaticBody2D

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var message_screen: Node2D = $MessageScreen
var interactor:Player = null

export(int, "Welcome message", "First component", "Second component", "Third component") var message_index = 0

func index_to_message():
	return [
		message_screen.WELCOME_MESSAGE, 
		message_screen.FIRST_COMPONENT_MESSAGE, 
		message_screen.SECOND_COMPONENT_MESSAGE, 
		message_screen.THIRD_COMPONENT_MESSAGE
	][message_index]

func _ready():
	print("ready")
	animation_player.play("blink")
	message_screen.show = false
	message_screen.message = index_to_message()

func _on_Area2D_body_entered(_body):
	#_body.connect("interact_pressed", self, "_on_near_interaction")
	#interactor = _body
	message_screen.show = true

func _on_Area2D_body_exited(_body):
	#disconnect("interact_pressed", _body, "_on_near_interaction")
	#interactor = null
	message_screen.show = false

#func _on_near_interaction():
#	print("hay interactor")
#	print(interactor != null)
#	print("como esta la screen?")
#	print(message_screen.show)
#	var show = not (interactor != null and message_screen.show)
#	print("nuevo estado")
#	print(show)
#	message_screen.show = show
#	print("se muestra la screen ahora?")
#	print(message_screen.show)
