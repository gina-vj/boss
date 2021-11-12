extends StaticBody2D

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var message_screen: Node2D = $MessageScreen

export(int, "Welcome message", "First component", "Second component", "Third component") var message_index = 0

func index_to_message():
	return [
		message_screen.WELCOME_MESSAGE, 
		message_screen.FIRST_COMPONENT_MESSAGE, 
		message_screen.SECOND_COMPONENT_MESSAGE, 
		message_screen.THIRD_COMPONENT_MESSAGE
	][message_index]
func _ready():
	animation_player.play("blink")
	message_screen.show = false
	message_screen.message = index_to_message()


func _on_Area2D_body_entered(body):
	message_screen.show = true	


func _on_Area2D_body_exited(body):
	message_screen.show = false
