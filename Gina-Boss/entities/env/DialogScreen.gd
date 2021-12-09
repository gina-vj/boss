extends Node2D

onready var dialog_container: Label = $Control/Message
onready var tween: Tween = $Tween

const FIRST_COMPONENT_DIALOG = ["",
"Genial, encontraste el primer componente de la vacuna y faltan 2 más. \n\nAbajo te dejé algunos items que espero te ayuden en tu búsqueda."
]

const END_TUTORIAL_DIALOG = ["","Gina, gracias por ayudarnos. \n\nRecuerda que las vacunas experimentales y el alcohol no hacen daño a los \n\ninfectados, pero te protegerán de ellos por pequeños lapsos de tiempo. \n\nAvanza hacia la plataforma para comenzar. Buena suerte"]

var selected_dialog_index
var TEXT_SPEED = 0.01
var dialog_index = 0
var selected_dialog

func _ready():
# warning-ignore:return_value_discarded
	PlayerData.connect("player_by_computer", self, "open")
# warning-ignore:return_value_discarded
	PlayerData.connect("player_leave_computer", self, "close")
	visible = false

func _input(event:InputEvent):
	if event.is_action_pressed("ui_accept") and selected_dialog != null:
		next_screen()

func next_screen():
	if(selected_dialog == null):
		selected_dialog = get_selected_dialog()	
	load_dialog()

func get_selected_dialog():
	return [
		FIRST_COMPONENT_DIALOG, 
		END_TUTORIAL_DIALOG
	][selected_dialog_index]

func load_dialog():	
	if dialog_index < selected_dialog.size():
		dialog_container.text = selected_dialog[dialog_index]
		dialog_container.percent_visible = 0
		var tween_duration = TEXT_SPEED * selected_dialog[dialog_index].length()
		
		# warning-ignore:return_value_discarded
		tween.interpolate_property(
			dialog_container, 
			"percent_visible", 
			0.0, 
			1.0, 
			tween_duration, 
			Tween.TRANS_LINEAR, 
			Tween.EASE_IN_OUT
		)
		
		# warning-ignore:return_value_discarded
		tween.start()	
		dialog_index += 1
	else: 
		close()

func close():
	selected_dialog_index = null
	self.dialog_index = 0
	selected_dialog = null
	visible = false

func open(_dialog_index):
	self.selected_dialog_index = _dialog_index
	self.dialog_index = 0
	visible = true
	next_screen()
