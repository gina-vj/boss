extends CanvasLayer

onready var countRed = $CountRed
onready var countYellow = $CountYellow
onready var countCyan = $CountCyan
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	$CountRed.text=str( Bag.count("rojo"))
	$CountYellow.text= str(Bag.count("amarillo"))
	$CountCyan.text= str(Bag.count("cyan"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
