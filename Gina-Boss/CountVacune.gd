extends CanvasLayer

onready var countRed = $CountRed
onready var countYellow = $CountYellow
onready var countCyan = $CountCyan

func _physics_process(delta):
	$CountRed.text=str( Bag.count("rojo"))
	$CountYellow.text= str(Bag.count("amarillo"))
	$CountCyan.text= str(Bag.count("verde"))


#Acá es donde estaría bueno que te vaya diciendo que te faltan componentes 
#para la vacuna.

#además estaría bueno que cuando levantes un item lanzable, te avise que podes tirarlos
