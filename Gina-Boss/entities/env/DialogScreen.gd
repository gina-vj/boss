extends Node2D

onready var dialog_container: Label = $Control/Message
onready var tween: Tween = $Tween

const WELCOME_DIALOG = [
"Gina, gracias por venir a ayudarnos. \n \n \nPara detener esta terrible pandemia debemos fabricar una vacuna compleja \n\nque requiere de 3 componentes muy escasos en el planeta. \n\nAntes de que todo estallara los teníamos listos, pero cuando los infectados \n\n", 
"ingresaron, los componentes quedaron perdidos por el laboratorio. \n\nNecesito tu ayuda para encontrarlos, reunirlos y llevarlos a la sala central \n\nque queda al final del edificio. \n\nEl problema es que para conseguirlos deberás recorrer el laboratorio que \n\n",
"se encuentra atestado de personas infectadas, \n\nte recomiendo que seas precavida y huyas si los tenes cerca. \n\nAntes de que te vayas: te dejé varias objetos para ayudarte, entre ellos \n\nel barbijo te va a permitir estar cerca de un infectado sin que te afecte, \n\npero recordá que se saturan, no te descuides. \n\n",
"Si te persiguen lo mejor es correr! \n\nRecordá no quedarte mucho cerca de ellos que te vas a contagiar! \n\nSuerte... \n\nla vas a necesitar..."]

const FIRST_COMPONENT_DIALOG = [
"¡Veo que lograste conseguir el primer componente! \n\nes una buena noticia pero no te relajes que los próximos dos sectores \n\nson los que están más atestados de estas personas infectadas!\n\n", 
"Seguramente ya viste que te dejé algunos items \n\nacá al lado que te pueden servir.. \n\nLas vacunas experimentales no curan a los infectados, pero\n\nte pueden dar el suficiente tiempo para huír, usalos con sabiduría!!"]

const SECOND_COMPONENT_DIALOG= [
"Que bueno verte en este sector porque significa que tu misión \n\nestá siendo exitosa, te confieso que me estaba preocupando un poco. \n\nNo hay tiempo que perder, te dejé unos items más al lado de la computadora \n\nque espero te ayuden a superar lo que viene.\n\n",
"Te recomiendo que tomes el pasillo Norte para ir al próximo \n\nsector en busca del siguiente componente. \n\nEstamos un paso más cerca de crear la vacuna que nos podría permitir \n\ncombatir la pandemia y todo gracias a tu valentía! \n\nUn consejo, podes usar botellas de alcohol para desinfectar momentáneamente la zona que rodea a los infectados..."]

const THIRD_COMPONENT_DIALOG = ["¡Gina, sos una guerrera! \n\nLogré desactivar la última barrera laser \n\nque bloqueaba el paso a la sala central. \n\nEsto se encuentra al Este de dónde encontraste el primer componente.\n\n",
"Corre hacia allí porque cada minuto que pasa hay más infectados, \n\nno hay tiempo que perder y acordate de usar tus items con sabiduría. \n\nNos vemos del otro lado!"]

const END_TUTORIAL_DIALOG = ["Gina, gracias a esta práctica, estás lista para ayudarnos con la mision! \n\n Recuerda que nuesras vacunas experimentales y alcohol no hacen daño a los infectados \n\n pero si te protegeran de ellos. \n\n Avanza hacia la plataforma para comenzar. Buena suerte"]

var selected_dialog_index
var TEXT_SPEED = 0.01
var dialog_index = 0
var selected_dialog

func _ready():
	PlayerData.connect("player_by_computer", self, "open")
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
		WELCOME_DIALOG, 
		FIRST_COMPONENT_DIALOG, 
		SECOND_COMPONENT_DIALOG, 
		THIRD_COMPONENT_DIALOG,
		END_TUTORIAL_DIALOG
	][selected_dialog_index]

func load_dialog():	
	if dialog_index < selected_dialog.size():
		dialog_container.text = selected_dialog[dialog_index]
		dialog_container.percent_visible = 0
		var tween_duration = TEXT_SPEED * selected_dialog[dialog_index].length()
		tween.interpolate_property(dialog_container, "percent_visible", 0.0, 1.0, 
		tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		dialog_index += 1
	else: 
		close()

func close():
	selected_dialog_index = null
	dialog_index = 0
	selected_dialog = null
	visible = false

func open(dialog_index):
	self.selected_dialog_index = dialog_index
	self.dialog_index = 0
	visible = true
	next_screen()
