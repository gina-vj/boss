extends StaticBody2D

onready var animation_player: AnimationPlayer = $AnimationPlayer

export(int, "Welcome", "First component", "Second component", "Third component") var dialog_index = 0

var interactor 
var opened = false

func _ready():
	animation_player.play("blink")

func _on_Area2D_body_entered(_body):
	interactor = _body

func _on_Area2D_body_exited(_body):
	interactor = null
	opened = false
	PlayerData.emit_signal("player_leave_computer")
	

func _input(event:InputEvent):
	if event.is_action_pressed("ui_accept") and interactor != null && !opened:
		opened = true
		PlayerData.emit_signal("player_by_computer", dialog_index)
