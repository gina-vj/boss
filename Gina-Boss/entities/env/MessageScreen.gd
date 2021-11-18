extends Node2D

onready var message_animation_player: AnimationPlayer = $ScreenAnimationPlayer
onready var message_container: Label = $MarginContainer/Message
onready var tween: Tween = $Tween

const WELCOME_MESSAGE: String = "Gina, gracias por venir a ayudarnos. \n Para detener esta terrible pandemia debemos fabricar una vacuna compleja \n que requiere de 3 componentes muy escasos en el planeta. \n Antes de que todo estallara los teníamos listos, pero cuando los infectados \n  ingresaron, los componentes quedaron perdidos por el laboratorio. \n Necesito tu ayuda para encontrarlos, reunirlos y la sala central que queda \n al final del edificio. El problema es que vas a tener que escabullirte en el \n laboratio atestado de infectados, recomiendo que seas precavida y que huyas si los tenes cerca. \n Antes de que te vayas: te dejé varias objetos para ayudarte, entre ellos el barbijo te va a \n permitir estar cerca de un infectado sin que te afecte, pero recordá que se saturan, \n por ende no te descuides. Si te persiguen lo mejor es correr! \n Recordá no quedarte mucho cerca de ellos que te vas a contagiar! \n Suerte... la vas a necesitar..."
const FIRST_COMPONENT_MESSAGE: String = "¡Veo que lograste conseguir el primer componente, \n es una buena noticia pero no te relajes que los próximos dos sectores \n son los que están más atestados de estas personas infectadas! \n Te dejé unos pocos items más para que te pueden ayudar. Las vacunas experimentales \n no curan a los infectados, pero te pueden dar el suficiente tiempo para huír, \n usalos con sabiduría!!"
const SECOND_COMPONENT_MESSAGE: String = "Que bueno que llegaste acá! Te confieso que me estaba preocupando un poco. \n No hay tiempo que perder, te dejé unos items al lado de la computadora y recomiendo \n  que tomes el pasillo Norte para ir al próximo sector y encontrar el siguiente componente. \n Estamos un paso más cerca de crear la vacuna que nos podría permitir combatir la pandemia y \n todo gracias a tu valentía! \n Un consejo, podes usar botellas de alcohol para desinfectar momentáneamente la zona que rodea a los infectados..."
const THIRD_COMPONENT_MESSAGE: String = "¡Gina, sos nuestra guerrera! \n Logre desactivar la última barrera laser que bloqueaba el paso a la sala central. \n Esto se encuentra al Este de dónde encontraste el primer componente. \n Corre hacia allí que cada vez ingresan más infectados, recuerda no hay tiempo que perder \n y de usar tus items con sabiduría. \n Nos vemos del otro lado!"

var message: String = "" setget set_message
var show = false setget set_show

func set_message(value):
	message_container.text = value
	message_container.percent_visible = 0
	message = value

func set_show(value):
	if value:
		tween.interpolate_property(message_container, "percent_visible", 0.0, 1.0, message.length() * 0.01)
		tween.start()

	visible = value
