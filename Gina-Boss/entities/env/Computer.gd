extends StaticBody2D

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var computer:Sprite=$Computer
onready var textInfo:TextEdit=$TextInfo

export(int, "Welcome", "First component", "Second component", "Third component", "Tutorial end") var dialog_index = 0

var interactor 
var opened = false

func _ready():
	animation_player.play("blink")

func _on_Area2D_body_entered(_body):
	interactor = _body
	
func _on_Area2D_body_exited(_body):
	interactor = null
	opened = false
	PlayerData.player_leave_computer()
	
func _input(event:InputEvent):
	if event.is_action_pressed("ui_accept") and interactor != null && !opened:
		opened = true
		PlayerData.player_by_computer(dialog_index)

func _on_AreaInfo_body_entered(body):
	if(body is Player):
		computer.material.set_shader_param("active",true)
		textInfo.visible=true
		textInfo.material.set_shader_param("active",true)

func _on_AreaInfo_body_exited(body):
	if(body is Player):
		computer.material.set_shader_param("active",false)
		textInfo.visible=false
		textInfo.material.set_shader_param("active",false)
