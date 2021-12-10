extends Node2D

onready var dialog_container: RichTextLabel = $Control/Message
onready var tween: Tween = $Tween
onready var indicator = $NextIndicator
onready var vaccine = $Vaccine
onready var vaccine2 = $Vaccine2
onready var vaccine3 = $Vaccine3

const END_TUTORIAL_DIALOG = ["","Gracias Gina. Necesitamos tu ayuda para [color=#a3f5b0]encontrar[/color] los [color=#a3f5b0]3 componentes[/color] \n\nnecesarios para fabricar la vacuna que salvará a la humanidad. \n\nLos [color=#a3f5b0]items[/color] que aprendiste a usar, sirven para [color=#a3f5b0]protegerte[/color] por cortos \n\n lapsos de tiempo de los infectados, pero [color=#a3f5b0]no les hacen daño real[/color]. \n\nAvanza hacia la plataforma para comenzar. Buena suerte"]
const INIT_LEVEL_ONE = ["","En este piso encontraras los componentes necesarios para la vacuna.\n\nConsigue los 3 para poder entregarmelos al final del nivel. \n\n[color=#a3f5b0]Evita[/color] que [color=#a3f5b0]los infectados[/color] más grandes y enojados [color=#a3f5b0]te encierren[/color] \n\ny procura usar tus items con sabiduría.\n\nUn consejo: [color=#a3f5b0]siempre que puedas[/color]... [color=#a3f5b0]corre!![/color]"]
const FIRST_COMPONENT_DIALOG = ["","Estupendo Gina, tenemos un componente y sólo quedan 2. \n\nContinua por este camino y luego sube por el pasillo \n\npara buscar los 2 componentes restantes. \n\n[color=#a3f5b0]No te relajes![/color]"]

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
		END_TUTORIAL_DIALOG,
		INIT_LEVEL_ONE, 
		FIRST_COMPONENT_DIALOG, 
	][selected_dialog_index]

func load_dialog():			
	if dialog_index < selected_dialog.size():
		self.dialog_container.bbcode_text = selected_dialog[dialog_index]
		self.dialog_container.percent_visible = 0
		var tween_duration = TEXT_SPEED * selected_dialog[dialog_index].length()
		
		# warning-ignore:return_value_discarded
		tween.interpolate_property(
			self.dialog_container, 
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
