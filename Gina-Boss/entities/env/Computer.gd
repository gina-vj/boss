extends StaticBody2D

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var dialog_screen: Node2D = $DialogScreen

export(int, "Welcome", "First component", "Second component", "Third component") var dialog_index = 0

var interactor 

func _ready():
	animation_player.play("blink")
	dialog_screen.selected_dialog_index = dialog_index

func _on_Area2D_body_entered(_body):
	_body.connect("interact_pressed", self, "_on_near_interaction")
	interactor = _body

func _on_Area2D_body_exited(_body):
	disconnect("interact_pressed", _body, "_on_near_interaction")
	dialog_screen.close()
	interactor = null
	
func _on_near_interaction():
	if(interactor != null):
		dialog_screen.next_screen()
