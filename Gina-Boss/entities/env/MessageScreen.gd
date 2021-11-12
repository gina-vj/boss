extends Node2D

onready var message_animation_player: AnimationPlayer = $ScreenAnimationPlayer
onready var message_container: Label = $MarginContainer/Message
onready var tween: Tween = $Tween

const WELCOME_MESSAGE: String = "¿Gina? \n ¡No puedo creer que hayas llegado hasta aca! Pense que quedaba solo yo... \n No tengo mucho tiempo para explicarte, pero necesitamos encontrar las 3 componentes que faltan para la vacuna. La unica informacion que tengo es que estan en algun lugar de este laboratorio. \n Por favor encontralas, cuando las tengas yo me volvere a contactar con vos. Pero antes de que te vayas lee bien lo que te digo: \n - Si necesitas mi ayuda podes usar estas terminales para contactarme, pero yo no contaria mucho con ello. \n - El laboratorio esta lleno de infectados, trata de evitarlos, mientras mas cerca los tengas mas chances de que te contagien. \n - Usa todo lo que tengas a tu alcance para defenderte y protegerte del virus, aca deje algunos elementos en caso de necesitarlos, tomalos, el acohol al menos te va a servir para desinfectar temporalmente y poder alejarte."
const FIRST_COMPONENT_MESSAGE: String = "¡Increible! \n Conseguiste la primer componente, y pasando por esa sala llena de infectados. \n Espero que no te hayas contagiado... \n Bueno, en buenas noticias aca te deje un traje que te puede ayudar, creo que va a evitar la infeccion a distancia, pero tene cuidado. \n Por otro lado en las no tan buenas noticias, si te parecio que la sala anterior tenia muchos infectados espera a ver la siguiente 0.0 \n ¡Suerte y espero saber de vos pronto!"
const SECOND_COMPONENT_MESSAGE: String = "Bueno realmente no tenia esperanzas de que llegues hasta aca ¯\\_(ツ)_/¯ \n Pero como soy muy precavide, deje algo de equipo que puede ayudarte. \n ¡Gina, si logras conseguir el ultimo componente tal ves podramos salvar a la humanidad! \n Aunque no estoy tan seguro de que sea algo bueno per se... \n ¡Suerte!"
const THIRD_COMPONENT_MESSAGE: String = "¡Gina, lo lograste! \n Logre desbloquear la barrera de lasers, cerca de donde encontraste la primera componente. \n Corre hacia alla que el laboratorio se esta llenando de infectados y no se de donde salieron, una ves que cruces esa barrera la voy a volver a encender. \n No te olvides de las componentes, nos vemos del otro lado. \n ¡Corre!"

var message: String = "" setget set_message
var show = false setget set_show

func set_message(value):
	message_container.text = value
	message_container.percent_visible = 0
	message = value

func set_show(value):
	if value:
		tween.interpolate_property(message_container, "percent_visible", 0.0, 1.0, message.length() * 0.05)
		tween.start()

	visible = value
