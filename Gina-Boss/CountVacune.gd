extends CanvasLayer




func _physics_process(delta):
	$CountRed.text=str( Bag.count("rojo"))
	$CountYellow.text= str(Bag.count("amarillo"))
	$CountAlcohol.text= str(Bag.cant_alcohol())
	$CountBarbijo.text= str(Bag.cantBarbijos)


#Acá es donde estaría bueno que te vaya diciendo que te faltan componentes 
#para la vacuna.

#además estaría bueno que cuando levantes un item lanzable, te avise que podes tirarlos
